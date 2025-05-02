<?php

namespace App\Controller\PostPopup;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;

class PostPopupController extends AbstractController
{
    #[Route('/post/popup', name: 'post_popup')]
    public function index(): Response
    {
        return $this->render('components/postPopup.html.twig');
    }

    #[Route('/api/post/create', name: 'api_post_create', methods: ['POST'])]
    public function createPost(Request $request): JsonResponse
    {
        // Verify CSRF token
        $submittedToken = $request->request->get('_token') ?: json_decode($request->getContent(), true)['_token'] ?? '';
        if (!$this->isCsrfTokenValid('post_create', $submittedToken)) {
            throw new AccessDeniedException('Invalid CSRF token.');
        }

        // Get the content
        $data = json_decode($request->getContent(), true);
        $content = $data['content'] ?? '';

        if (empty($content)) {
            return new JsonResponse(['message' => 'Content cannot be empty'], 400);
        }

        // Simulate saving the post (in a real app, save to database)
        $postId = random_int(1, 1000); // Mock ID

        // Generate URLs for the response
        $feedUrl = $this->generateUrl('global_feed');
        $userUrl = $this->generateUrl('user_profile', ['username' => 'KodoNinja']);

        return new JsonResponse([
            'message' => 'Post created successfully',
            'post_id' => $postId,
            'feed_url' => $feedUrl,
            'user_url' => $userUrl,
        ], 201);
    }
}
