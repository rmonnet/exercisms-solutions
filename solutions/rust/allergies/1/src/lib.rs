pub struct Allergies {
    score: u32,
}

#[derive(Debug, PartialEq, Copy, Clone)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
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
        let index:u32 = match allergen {
            Allergen::Eggs => 1,
            Allergen::Peanuts => 2,
            Allergen::Shellfish => 4,
            Allergen::Strawberries => 8,
            Allergen::Tomatoes => 16,
            Allergen::Chocolate => 32,
            Allergen::Pollen => 64,
            Allergen::Cats => 128,
        };
        real_score & index != 0
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
