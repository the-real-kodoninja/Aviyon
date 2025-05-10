<?php

namespace App\Controller\News;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ArticlesController extends AbstractController
{
    #[Route('/news/articles/{date}/{title}', name: 'news_article')]
    public function view(string $date, string $title): Response
    {
        return $this->render('news/articles/articleTemplate.html.twig', [
            'date' => $date,
            'article_title' => $title,
        ]);
    }

    #[Route('/news/articles/new', name: 'news_article_new')]
    public function new(): Response
    {
        return $this->render('news/articles/articlePost.html.twig');
    }

    #[Route('/news/articles/{id}/edit', name: 'news_article_edit')]
    public function edit(string $id): Response
    {
        // Placeholder for fetching article data
        $article = [
            'title' => 'Sample Article',
            'content' => '<p>Lorem ipsum dolor sit amet...</p>',
        ];

        return $this->render('news/articles/articleEdit.html.twig', [
            'article' => $article,
        ]);
    }

    #[Route('/{path}', name: 'articles_redirect', requirements: ['path' => 'article|articles'], defaults: ['path' => null], methods: ['GET'])]
    #[Route('/articles', name: 'articles')]
    public function index(): Response
    {
        $categories = [
            'technology' => [
                [
                    'id' => 1,
                    'title' => 'Aviyon’s $10B AI Revolution',
                    'author' => 'Nimbus AI',
                    'date' => '2025-05-09',
                    'content' => 'Unveiling the future of AI with a $10B investment in nimbus.ai...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/ai-revolution.jpg',
                    'likes' => 1200,
                    'comments' => 89,
                    'category' => 'technology',
                    'location' => 'Global',
                    'ai_generated' => true
                ],
                [
                    'id' => 5,
                    'title' => 'Quantum Computing Breakthrough',
                    'author' => 'Tech Team',
                    'date' => '2025-05-05',
                    'content' => 'A new milestone in quantum computing technology...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/quantum-breakthrough.jpg',
                    'likes' => 300,
                    'comments' => 15,
                    'category' => 'technology',
                    'location' => 'KodoCity',
                    'ai_generated' => false
                ]
            ],
            'kodoverse' => [
                [
                    'id' => 2,
                    'title' => 'Kodoverse VR Expansion',
                    'author' => 'Velocity Team',
                    'date' => '2025-05-08',
                    'content' => 'Expanding the virtual world with cutting-edge VR technology...',
                    'media' => 'video',
                    'mediaSrc' => '/build/videos/vr-expansion.mp4',
                    'likes' => 850,
                    'comments' => 45,
                    'category' => 'kodoverse',
                    'location' => 'Virtual',
                    'ai_generated' => false
                ],
                [
                    'id' => 6,
                    'title' => 'Kodoverse Metaverse Updates',
                    'author' => 'Kodoverse Team',
                    'date' => '2025-05-04',
                    'content' => 'New features in the Kodoverse metaverse...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/metaverse-update.jpg',
                    'likes' => 400,
                    'comments' => 25,
                    'category' => 'kodoverse',
                    'location' => 'Virtual',
                    'ai_generated' => false
                ]
            ],
            'insights' => [
                [
                    'id' => 3,
                    'title' => 'AI Ethics in 2025',
                    'author' => 'Nimbus AI',
                    'date' => '2025-05-07',
                    'content' => 'Exploring the ethical boundaries of AI development...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/ai-ethics.jpg',
                    'likes' => 600,
                    'comments' => 30,
                    'category' => 'insights',
                    'location' => 'Global',
                    'ai_generated' => true
                ],
                [
                    'id' => 7,
                    'title' => 'Future of Work with AI',
                    'author' => 'Insights Team',
                    'date' => '2025-05-03',
                    'content' => 'How AI is shaping the future workplace...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/future-work.jpg',
                    'likes' => 350,
                    'comments' => 18,
                    'category' => 'insights',
                    'location' => 'Global',
                    'ai_generated' => false
                ]
            ],
            'events' => [
                [
                    'id' => 4,
                    'title' => 'KodoCity Urban Milestone',
                    'author' => 'KodoCity Team',
                    'date' => '2025-05-06',
                    'content' => 'A $5B urban project reaches a new phase...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/kodocity-milestone.jpg',
                    'likes' => 450,
                    'comments' => 20,
                    'category' => 'events',
                    'location' => 'KodoCity',
                    'ai_generated' => false
                ],
                [
                    'id' => 8,
                    'title' => 'Aviyon Tech Summit 2025',
                    'author' => 'Events Team',
                    'date' => '2025-05-02',
                    'content' => 'Join us for the annual tech summit in KodoCity...',
                    'media' => 'image',
                    'mediaSrc' => '/build/images/tech-summit.jpg',
                    'likes' => 500,
                    'comments' => 22,
                    'category' => 'events',
                    'location' => 'KodoCity',
                    'ai_generated' => false
                ]
            ]
        ];

        return $this->render('pages/articles.html.twig', [
            'categories' => $categories
        ]);
    }
}
