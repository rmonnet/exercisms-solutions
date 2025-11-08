pub struct Allergies {
    score: u32,
}

#[derive(Debug, PartialEq, Copy, Clone)]
pub enum Allergen {
    Eggs = 1,
    Peanuts = 2,
    Shellfish = 4,
    Strawberries = 8,
    Tomatoes = 16,
    Chocolate = 32,
    Pollen = 64,
    Cats = 128,
}

impl Allergen {
    const VALUES: [Self; 8] = [
        Self::Eggs,  Self::Peanuts, Self::Shellfish, Self::Strawberries,
        Self::Tomatoes, Self::Chocolate, Self::Pollen, Self::Cats,
    ];
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        Allergies{score: score}
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
       let real_score = if self.score >= 256 {self.score - 256} else {self.score};
        real_score & (*allergen as u32) != 0
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        let mut allergies = Vec::<Allergen>::new();
        for allergen in Allergen::VALUES.iter() {
            if self.is_allergic_to(allergen) {
                allergies.push(*allergen);
            }
        }
        allergies
    }
}
