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
        return $this->render('landing.html.twig');
    }

    #[Route('/login', name: 'login', methods: ['GET', 'POST'])]
    public function login(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            // Placeholder: Handle login logic (e.g., authenticate user)
            $username = $request->request->get('username');
            $password = $request->request->get('password');
            // Add actual authentication logic here
            $this->addFlash('success', 'Login successful! Welcome, ' . $username);
            return $this->redirectToRoute('app_root');
        }
        return $this->render('auth/login.html.twig');
    }

    #[Route('/signup', name: 'signup', methods: ['GET', 'POST'])]
    public function signup(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            // Placeholder: Handle signup logic (e.g., create user)
            $username = $request->request->get('username');
            $email = $request->request->get('email');
            $password = $request->request->get('password');
            // Add actual user creation logic here
            $this->addFlash('success', 'Signup successful! Welcome, ' . $username);
            return $this->redirectToRoute('app_root');
        }
        return $this->render('auth/signup.html.twig');
    }
}
