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
    #[Route('/docs/{path}', name: 'docs_catchall', requirements: ['path' => '.+'])]
    public function aviyonNotes(Request $request): Response
    {
        $this->logger->info('Serving Aviyon Notes from /docs with path: ' . $request->getPathInfo());
        return $this->file('index.html', true); // Serve Vite app for all /docs routes
    }
}
