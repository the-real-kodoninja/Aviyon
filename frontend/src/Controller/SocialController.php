<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SocialController extends AbstractController
{
    #[Route('/comment', name: 'add_comment', methods: ['POST'])]
    public function addComment(Request $request): Response
    {
        return $this->redirectToRoute('dashboard');
    }

    #[Route('/like', name: 'like_post', methods: ['POST'])]
    public function likePost(Request $request): Response
    {
        return $this->json(['likes' => 1]); // Placeholder response
    }
}
