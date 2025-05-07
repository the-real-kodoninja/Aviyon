<?php

namespace App\Controller;

use App\Controller\Investing\FeedController;
use App\Controller\Investing\SocialTradingController;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class InvestingController extends AbstractController
{
    private $feedController;
    private $socialTradingController;

    public function __construct(FeedController $feedController, SocialTradingController $socialTradingController)
    {
        $this->feedController = $feedController;
        $this->socialTradingController = $socialTradingController;
    }

    public function index(): Response
    {
        $posts = $this->feedController->getInitialPosts();

        return $this->render('pages/investing.html.twig', [
            'posts' => $posts,
        ]);
    }

    public function submitNonEquity(Request $request): Response
    {
        // Handle non-equity investment form submission
        return $this->redirectToRoute('investing');
    }

    public function submitEquity(Request $request): Response
    {
        // Handle equity investment form submission
        return $this->redirectToRoute('investing');
    }
}
