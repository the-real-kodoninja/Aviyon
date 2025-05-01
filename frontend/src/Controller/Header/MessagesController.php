<?php

namespace App\Controller\Header;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class MessagesController extends AbstractController
{
    #[Route('/header/messages', name: 'header_messages')]
    public function index(): Response
    {
        // In a real application, this would fetch messages from a database
        return $this->render('components/header/messages.html.twig');
    }
}
