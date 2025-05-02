<?php

namespace App\Controller\Bulletinboard;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;

class BulletinboardController extends AbstractController
{
    #[Route('/bulletinboard', name: 'bulletinboard')]
    public function index(): Response
    {
        return $this->render('pages/bulletinboard.html.twig');
    }

    #[Route('/api/bulletin/create', name: 'api_bulletin_create', methods: ['POST'])]
    public function createBulletin(Request $request): JsonResponse
    {
        // Verify CSRF token
        $submittedToken = $request->request->get('_token') ?: json_decode($request->getContent(), true)['_token'] ?? '';
        if (!$this->isCsrfTokenValid('bulletin_create', $submittedToken)) {
            throw new AccessDeniedException('Invalid CSRF token.');
        }

        // Get the title and content
        $data = json_decode($request->getContent(), true);
        $title = $data['title'] ?? '';
        $content = $data['content'] ?? '';

        if (empty($title) || empty($content)) {
            return new JsonResponse(['message' => 'Title and content cannot be empty'], 400);
        }

        // Simulate saving the bulletin (in a real app, save to database)
        $bulletinId = random_int(1, 1000); // Mock ID

        return new JsonResponse([
            'message' => 'Bulletin created successfully',
            'bulletin_id' => $bulletinId,
        ], 201);
    }
}
