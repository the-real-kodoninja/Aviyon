<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\BinaryFileResponse;

class DocsController extends AbstractController
{
    #[Route('/docs', name: 'docs')]
    public function docs(): Response
    {
        return $this->render('pages/docs.html.twig');
    }

    #[Route('/docs/{file<.+>}', name: 'docs_file')]
    public function serveDocsFile(string $file): Response
    {
        // Assuming Markdown files are stored in a directory like 'docs'
        $filePath = $this->getParameter('kernel.project_dir') . '/docs/' . $file;
        if (!file_exists($filePath)) {
            throw $this->createNotFoundException('Documentation file not found');
        }

        return new Response(file_get_contents($filePath), 200, [
            'Content-Type' => 'text/markdown',
        ]);
    }
}
