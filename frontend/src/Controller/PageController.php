<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;

class PageController extends AbstractController
{
    public function features(): Response
    {
        return $this->render('pages/features.html.twig');
    }

    public function about(): Response
    {
        return $this->render('pages/about.html.twig');
    }

    public function checkout(): Response
    {
        return $this->render('pages/checkout.html.twig');
    }

    public function domain(): Response
    {
        return $this->render('pages/domain.html.twig');
    }

    public function search(): Response
    {
        return $this->render('pages/search.html.twig');
    }

    public function user(): Response
    {
        return $this->render('pages/user.html.twig');
    }

    public function settings(): Response
    {
        return $this->render('pages/settings.html.twig');
    }
}
