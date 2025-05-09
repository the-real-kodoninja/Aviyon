<?php

namespace App\Controller\Bulletinboard;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class BulletinboardController extends AbstractController
{
    #[Route('/bulletinboard', name: 'bulletinboard')]
    public function index(): Response
    {
        return $this->render('pages/bulletinboard.html.twig');
    }

    #[Route('/api/bulletin/list', name: 'api_bulletin_list', methods: ['GET'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function listBulletins(): JsonResponse
    {
        $bulletins = [
            [
                'id' => 1,
                'title' => 'Grand Opening of Aviyon Marketplace',
                'author' => 'Kodoverse Team',
                'date' => '2025-05-15',
                'content' => 'Join us for the grand opening with exclusive NFT drops and live demos!',
                'media' => 'video',
                'mediaSrc' => '/build/videos/marketplace_opening.mp4',
                'likes' => 145,
                'comments' => 23,
                'category' => 'events',
                'location' => 'KodoCity'
            ],
            [
                'id' => 2,
                'title' => 'Kodoverse Update: New VR Features',
                'author' => 'Velocity Team',
                'date' => '2025-05-10',
                'content' => 'Experience the latest VR updates in the Kodoverse with Velocity Esports.',
                'media' => 'image',
                'mediaSrc' => '/build/images/kodoverse-vr.jpg',
                'likes' => 320,
                'comments' => 45,
                'category' => 'updates',
                'location' => 'Virtual'
            ],
            [
                'id' => 3,
                'title' => 'KodoCity Construction Milestone',
                'author' => 'KodoCity Team',
                'date' => '2025-05-08',
                'content' => 'We’ve reached a major milestone in KodoCity’s $5B urban project!',
                'media' => 'image',
                'mediaSrc' => '/build/images/kodocity-milestone.jpg',
                'likes' => 280,
                'comments' => 19,
                'category' => 'updates',
                'location' => 'KodoCity'
            ],
            [
                'id' => 4,
                'title' => 'Global Tech Summit 2025',
                'author' => 'Aviyon Events',
                'date' => '2025-06-01',
                'content' => 'Join us for a global tech summit with keynote speakers and live demos.',
                'media' => 'video',
                'mediaSrc' => '/build/videos/tech-summit.mp4',
                'likes' => 410,
                'comments' => 67,
                'category' => 'events',
                'location' => 'Global'
            ]
        ];
        return new JsonResponse($bulletins);
    }

    #[Route('/api/bulletin/create', name: 'api_bulletin_create', methods: ['POST'])]
    public function createBulletin(Request $request): JsonResponse
    {
        $submittedToken = $request->request->get('_token') ?: json_decode($request->getContent(), true)['_token'] ?? '';
        if (!$this->isCsrfTokenValid('bulletin_create', $submittedToken)) {
            throw new AccessDeniedException('Invalid CSRF token.');
        }

        $data = json_decode($request->getContent(), true);
        $title = $data['title'] ?? '';
        $content = $data['content'] ?? '';

        if (empty($title) || empty($content)) {
            return new JsonResponse(['message' => 'Title and content cannot be empty'], 400);
        }

        $bulletinId = random_int(1, 1000);
        return new JsonResponse([
            'message' => 'Bulletin created successfully',
            'bulletin_id' => $bulletinId,
            'feed_url' => $this->generateUrl('bulletinboard'),
            'user_url' => $this->generateUrl('user')
        ], 201);
    }

    #[Route('/api/ai/assist', name: 'api_ai_assist', methods: ['POST'])]
    public function aiAssist(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $prompt = $data['prompt'] ?? 'Suggest a bulletin post';
        $suggestions = [
            'Suggest a bulletin post' => 'Title: Upcoming Tech Summit\nContent: Join us on June 1, 2025, for a global tech summit with keynote speakers!',
            'Suggest content for a bulletin post about KodoCity' => 'Title: KodoCity Progress Update\nContent: KodoCity reaches a new milestone with sustainable infrastructure!',
            'Suggest a search query for KodoCity events' => 'Try searching for "KodoCity events 2025"'
        ];
        $suggestion = $suggestions[$prompt] ?? 'Title: General Update\nContent: Stay tuned for more exciting news from Aviyon!';
        return new JsonResponse(['suggestion' => $suggestion]);
    }

    #[Route('/bulletinboard/post/{id}', name: 'bulletin_post', methods: ['GET'])]
    public function show(int $id): Response
    {
        $bulletins = [
            1 => [
                'id' => 1,
                'title' => 'Grand Opening of Aviyon Marketplace',
                'author' => 'Kodoverse Team',
                'date' => '2025-05-15',
                'content' => 'Join us for the grand opening with exclusive NFT drops and live demos! We’re excited to unveil our new marketplace features, including seamless NFT trading and live product demonstrations. Don’t miss out on this milestone event in KodoCity!',
                'media' => 'video',
                'mediaSrc' => '/build/videos/marketplace_opening.mp4',
                'likes' => 145,
                'comments' => 23,
                'category' => 'events',
                'location' => 'KodoCity'
            ],
            2 => [
                'id' => 2,
                'title' => 'Kodoverse Update: New VR Features',
                'author' => 'Velocity Team',
                'date' => '2025-05-10',
                'content' => 'Experience the latest VR updates in the Kodoverse with Velocity Esports. Our new features include enhanced graphics, improved latency, and new interactive environments for an immersive gaming experience.',
                'media' => 'image',
                'mediaSrc' => '/build/images/kodoverse-vr.jpg',
                'likes' => 320,
                'comments' => 45,
                'category' => 'updates',
                'location' => 'Virtual'
            ],
            3 => [
                'id' => 3,
                'title' => 'KodoCity Construction Milestone',
                'author' => 'KodoCity Team',
                'date' => '2025-05-08',
                'content' => 'We’ve reached a major milestone in KodoCity’s $5B urban project! The central hub is now complete, featuring sustainable energy solutions and smart infrastructure to support our growing community.',
                'media' => 'image',
                'mediaSrc' => '/build/images/kodocity-milestone.jpg',
                'likes' => 280,
                'comments' => 19,
                'category' => 'updates',
                'location' => 'KodoCity'
            ],
            4 => [
                'id' => 4,
                'title' => 'Global Tech Summit 2025',
                'author' => 'Aviyon Events',
                'date' => '2025-06-01',
                'content' => 'Join us for a global tech summit with keynote speakers and live demos. This event will feature industry leaders discussing the future of AI, VR, and urban development, along with hands-on demonstrations of our latest technologies.',
                'media' => 'video',
                'mediaSrc' => '/build/videos/tech-summit.mp4',
                'likes' => 410,
                'comments' => 67,
                'category' => 'events',
                'location' => 'Global'
            ]
        ];

        $bulletin = $bulletins[$id] ?? null;

        if (!$bulletin) {
            throw $this->createNotFoundException('Bulletin not found');
        }

        return $this->render('components/bulletinboard/bulletin_post.html.twig', [
            'bulletin' => $bulletin
        ]);
    }
}
