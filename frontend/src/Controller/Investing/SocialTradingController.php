<?php

namespace App\Controller\Investing;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SocialTradingController
{
    #[Route('/investing/social-trading/share', name: 'social_trading_share', methods: ['POST'])]
    public function shareStrategy(Request $request): Response
    {
        // Handle strategy sharing
        return $this->redirectToRoute('investing');
    }
}
