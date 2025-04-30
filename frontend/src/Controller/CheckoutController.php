<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class CheckoutController extends AbstractController
{
    #[Route('/checkout', name: 'checkout')]
    public function checkout(): Response
    {
        // Mock cart data
        $cart = [
            'items' => [
                [
                    'name' => 'Aviyon Avatar #1',
                    'price' => '2.5',
                    'currency' => 'ETH',
                ],
                [
                    'name' => 'Kodo Art #42',
                    'price' => '1.8',
                    'currency' => 'ETH',
                ],
            ],
            'total' => '4.3',
            'currency' => 'ETH',
        ];

        return $this->render('pages/checkout.html.twig', [
            'cart' => $cart,
        ]);
    }

    #[Route('/checkout/process', name: 'checkout_process', methods: ['POST'])]
    public function process(Request $request): Response
    {
        // Placeholder for payment processing logic
        $this->addFlash('success', 'Payment processed successfully!');
        return $this->redirectToRoute('dashboard');
    }
}
