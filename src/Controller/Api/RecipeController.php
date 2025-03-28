<?php

namespace App\Controller\Api;

use App\Repository\RecipeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class RecipeController extends AbstractController
{
    #[Route('/api/recipes', name: 'api_recipes_list', methods: ['GET'])]
    public function list(RecipeRepository $recipeRepository): JsonResponse
    {
        $recipes = $recipeRepository->findAll();

        $data = ['hola'];

        foreach ($recipes as $recipe) {
            $data[] = [
                'id' => $recipe->getId(),
                'title' => $recipe->getTitle(),
                'description' => $recipe->getDescription(),
                'createdAt' => $recipe->getCreatedAt()->format('Y-m-d H:i:s'),
                'author' => $recipe->getAuthor()->getName(),
            ];
        }

        return $this->json($data);
    }
}
