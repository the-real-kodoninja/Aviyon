<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class AuthController extends AbstractController
{
    public function root(): Response
    {
        return $this->render('pages/landing.html.twig');
    }

    public function login(Request $request): Response
    {
        return $this->render('auth/login.html.twig');
    }

    public function signup(Request $request): Response
    {
        return $this->render('auth/signup.html.twig');
    }

    public function logout(): Response
    {
        throw new \Exception('This method should be intercepted by the logout key on your firewall');
    }
}
