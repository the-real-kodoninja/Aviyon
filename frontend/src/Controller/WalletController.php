<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class WalletController extends AbstractController
{
    #[Route('/dashboard/wallet', name: 'wallet')]
    public function index(): Response
    {
        // Mock data for the wallet
        $walletData = [
            'balances' => [
                'AviyonCoin' => 0.00,
                'NimbusCoin' => 0.00,
                'Kodotoken' => 0.00,
                'KodoTOken' => 0.00,
                'VelocityCoin' => 0.00,
                'VelocityToken' => 0.00,
            ],
            'transactions' => [
                ['id' => 1, 'type' => 'Deposit', 'amount' => '100.00 AVC', 'date' => '2025-04-29', 'status' => 'Completed'],
                ['id' => 2, 'type' => 'Withdrawal', 'amount' => '50.00 KDC', 'date' => '2025-04-28', 'status' => 'Pending'],
            ],
            'portfolio' => [
                ['coin' => 'AviyonCoin', 'percentage' => 0],
                ['coin' => 'NimbusCoin', 'percentage' => 0],
                ['coin' => 'Kodotoken', 'percentage' => 0],
                ['coin' => 'KodoTOken', 'percentage' => 0],
                ['coin' => 'VelocityCoin', 'percentage' => 0],
                ['coin' => 'VelocityToken', 'percentage' => 0],
            ],
        ];

        return $this->render('dashboard/wallet.html.twig', [
            'wallet' => $walletData,
        ]);
    }
}
