<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PostController extends AbstractController
{
    #[Route('/post/{id}', name: 'post_view', methods: ['GET'])]
    public function viewPost(string $id): Response
    {
        // Placeholder logic to view a post
        return $this->render('components/post.html.twig', [
            'postId' => $id,
        ]);
    }

    #[Route('/post/{id}/comment', name: 'post_comment', methods: ['POST'])]
    public function addComment(string $id): Response
    {
        // Placeholder logic to add a comment
        return $this->json(['message' => 'Comment added to post ' . $id]);
    }
}
