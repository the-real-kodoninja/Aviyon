<?php

namespace App\Controller\Investing;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class FeedController
{
    public function getInitialPosts(): array
    {
        return [
            ['id' => 1, 'content' => 'Purchased $100,000 in AVN Tokens.', 'timestamp' => '2 hours ago', 'likes' => 0],
            ['id' => 2, 'content' => 'New blog post: "The Future of Web3 Investing"', 'timestamp' => '1 day ago', 'likes' => 0],
        ];
    }

    #[Route('/investing/feed', name: 'investing_feed')]
    public function fetchFeed(Request $request): JsonResponse
    {
        $page = (int) $request->query->get('page', 1);
        $posts = [
            ['id' => 3, 'content' => 'Expanded NFT Marketplace.', 'timestamp' => '3 days ago', 'likes' => 0],
            ['id' => 4, 'content' => 'Launched Chess.social.', 'timestamp' => '5 days ago', 'likes' => 0],
        ];

        return new JsonResponse(['posts' => $posts]);
    }

    #[Route('/investing/add-comment', name: 'add_comment', methods: ['POST'])]
    public function addComment(Request $request): Response
    {
        // Handle comment submission
        return $this->redirectToRoute('investing');
    }
}
