<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Psr\Log\LoggerInterface;

class DocsController extends AbstractController
{
    private $logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    #[Route('/docs', name: 'docs')]
    public function docs(): Response
    {
        return $this->render('pages/docs.html.twig');
    }

    #[Route('/docs/{file<.+>}', name: 'docs_file')]
    public function serveDocsFile(string $file): Response
    {
        // Decode URL to handle spaces correctly
        $normalizedFile = urldecode($file);
        $filePath = $this->getParameter('kernel.project_dir') . '/public/docs/' . $normalizedFile;
        $this->logger->info("Attempting to serve Markdown file: {$filePath}");
        
        if (!file_exists($filePath)) {
            $this->logger->error("Markdown file not found: {$filePath}");
            throw $this->createNotFoundException('Documentation file not found: ' . $filePath);
        }

        $content = file_get_contents($filePath);
        $this->logger->info("Successfully read Markdown file: {$filePath}");
        $response = new Response($content, 200);
        $response->headers->set('Content-Type', 'text/markdown');
        return $response;
    }
}
