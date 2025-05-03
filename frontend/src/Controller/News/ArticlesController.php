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
}
