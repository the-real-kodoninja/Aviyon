<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class DocsController extends AbstractController
{
    #[Route('/docs', name: 'docs')]
    public function docs(): Response
    {
        return $this->render('pages/docs.html.twig');
    }

    #[Route('/docs/{file}', name: 'docs_file')]
    public function serveDocsFile(string $file): Response
    {
        $filePath = $this->getParameter('kernel.project_dir') . '/public/docs/' . $file;
        if (!file_exists($filePath)) {
            throw $this->createNotFoundException('Documentation file not found: ' . $filePath);
        }

        $content = file_get_contents($filePath);
        $response = new Response($content, 200);
        $response->headers->set('Content-Type', 'text/markdown');
        return $response;
    }
}
