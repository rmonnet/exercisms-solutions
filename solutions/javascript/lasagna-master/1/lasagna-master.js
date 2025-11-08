/// <reference path="./global.d.ts" />
// @ts-check

/**
 * Checks if the lasagna is done. Return the cooking status.
 */
export function cookingStatus(remainingTime) {
  
  if (remainingTime === undefined) return 'You forgot to set the timer.'; 
  
  if (remainingTime <= 0) return 'Lasagna is done.';
  
  return 'Not done, please wait.';
}

/**
 * Computes the preparation time for the Lasagna based on the number of layers.
 * If preparation time is not provided, assume 2mn per layer.
 */
export function preparationTime(layers, timePerLayer = 2) {

  return layers.length * timePerLayer;
}

/**
 * Computes the quantities of noodles and sauce required for a specific recipe.
 */
export function quantities(layers) {
  const result = {noodles: 0, sauce: 0};
  for (const layer of layers) {
    switch (layer) {
      case 'sauce':
        result.sauce += 0.2;
        break;
      case 'noodles':
        result.noodles += 50;
        break;
    }
  }
  return result;
}

/**
 * Adds a secret ingredient (last item in the first recipe) to your recipe (the second recipe).
 * The function doesn't return any result (undefined). The first recipe is unchanged.
 * The second recipe has the secret incredient added to the end.
 */
export function addSecretIngredient(friendList, myList) {
  const secretIngredient = friendList[friendList.length-1];
  myList.push(secretIngredient);
}

/**
 * Scales the recipe from 2 portions to the specified number of portions.
 * Each item in the recipe is scaled approprietly.
 */
export function scaleRecipe(recipe, portions) {
  const scale = portions / 2;
  const scaledRecipe = {};
  for (let ingredient in recipe) {
    scaledRecipe[ingredient] = recipe[ingredient] * scale;
  }
  return scaledRecipe;
}
