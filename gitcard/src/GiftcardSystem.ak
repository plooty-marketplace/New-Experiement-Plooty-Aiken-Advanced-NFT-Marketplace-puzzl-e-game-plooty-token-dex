
contract GiftcardSystem {

    const swap_fee = 0.01;

    pub fn swap_giftcard_for_ada(giftcard_value: Value) -> Value {
        let fee = giftcard_value * swap_fee;
        giftcard_value - fee
    }

    pub fn earn_token_from_game(player: PubKeyHash, game_result: Integer) -> Value {
        if game_result > 100 {
            1000
        } else {
            500
        }
    }
}
