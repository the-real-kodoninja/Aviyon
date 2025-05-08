<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DomainController extends AbstractController
{
    #[Route('/domain', name: 'domain')]
    public function domain(): Response
    {
        return $this->render('pages/domain.html.twig');
    }

    #[Route('/domain/register', name: 'register_domain', methods: ['POST'])]
    public function registerDomain(Request $request): Response
    {
        $subdomain = $request->request->get('subdomain');
        $domainExtension = $request->request->get('domain_extension', '.aviyon.com');
        $fullDomain = $subdomain . $domainExtension;
        // Add logic to register the subdomain (e.g., save to database, check availability)
        $this->addFlash('success', "Subdomain '$fullDomain' registered successfully!");
        return $this->redirectToRoute('hosting', ['domain' => $fullDomain]);
    }
}
