<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PagesController extends AbstractController
{
    #[Route('/about', name: 'about')]
    public function about(): Response
    {
        return $this->render('pages/about.html.twig');
    }

    #[Route('/features', name: 'features')]
    public function features(): Response
    {
        return $this->render('pages/features.html.twig');
    }

    #[Route('/explore', name: 'explore')]
    public function explore(): Response
    {
        return $this->render('pages/explore.html.twig');
    }

    #[Route('/newsletter/subscribe', name: 'newsletter_subscribe', methods: ['POST'])]
    public function subscribeNewsletter(Request $request): Response
    {
        return $this->redirectToRoute('app_root');
    }

    #[Route('/terms', name: 'terms')]
    public function terms(): Response
    {
        return $this->render('pages/terms.html.twig');
    }

    #[Route('/privacy', name: 'privacy')]
    public function privacy(): Response
    {
        return $this->render('pages/privacy.html.twig');
    }

    #[Route('/contact', name: 'contact')]
    public function contact(): Response
    {
        return $this->render('pages/contact.html.twig');
    }
}
