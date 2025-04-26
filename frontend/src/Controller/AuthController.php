<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AuthController extends AbstractController
{
    #[Route('/', name: 'app_root')]
    public function root(): Response
    {
        return $this->render('pages/landing.html.twig');
    }

    #[Route('/landing', name: 'landing')]
    public function landing(): Response
    {
        return $this->render('pages/landing.html.twig');
    }

    #[Route('/login', name: 'login')]
    public function login(): Response
    {
        return $this->render('auth/login.html.twig');
    }

    #[Route('/signup', name: 'signup')]
    public function signup(): Response
    {
        return $this->render('auth/signup.html.twig');
    }

    #[Route('/logout', name: 'logout')]
    public function logout(): Response
    {
        return $this->redirectToRoute('app_root');
    }

    #[Route('/password/reset', name: 'password_reset')]
    public function passwordReset(): Response
    {
        return $this->render('auth/password_reset.html.twig');
    }

    #[Route('/2fa/verify', name: '2fa_verify', methods: ['POST'])]
    public function verify2FA(Request $request): Response
    {
        return $this->redirectToRoute('dashboard');
    }
    #
    public function docs(): Response
    {
       return $this->render('pages/docs.html.twig');
    }
}
