<?php
// src/Controller/IdeController.php
namespace App\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class IdeController extends AbstractController
{
    #[Route('/ide', name: 'ide')]
    public function index(): Response
    {
        return $this->render('ide/index.html.twig');
    }
}
