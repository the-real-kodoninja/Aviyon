<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PagesController extends AbstractController
{
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

    #[Route('/checkout', name: 'checkout')]
    public function checkout(): Response
    {
        return $this->render('pages/checkout.html.twig');
    }

    #[Route('/domain', name: 'domain')]
    public function domain(): Response
    {
        return $this->render('pages/domain.html.twig');
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

    #[Route('/contact/submit', name: 'contact_submit', methods: ['POST'])]
    public function contactSubmit(Request $request): Response
    {
        // Placeholder for contact form submission logic
        return $this->redirectToRoute('contact');
    }

    #[Route('/sitemap', name: 'sitemap')]
    public function sitemap(): Response
    {
        return $this->render('pages/sitemap.html.twig');
    }

    #[Route('/feed', name: 'global_feed', methods: ['GET'])]
    public function globalFeed(): Response
    {
        return $this->render('pages/feed.html.twig');
    }

}
