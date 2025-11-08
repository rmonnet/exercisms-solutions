
const A_CODE = 'a'.charCodeAt(0);
const Z_CODE = 'z'.charCodeAt(0);

// Defines a Class for the Caesar Cipher providing encoding and decoding.
export class Cipher {

  // Constructs a Caesar cipher.
  //
  // Each letter of the message is shifted in the alphabet according to the distance from 'a' to
  // the corresponding letter from the key (i.e if the key is 'abc', then the first letter of the
  // msg will be shifted up by 1 position, the second up by 2 positions and the third by 3 positions).
  // nce the message reaches the last letter of the key, the key is recycled from its first position.
  // (i.e. in our example, the 4th letter in the key is 'a', the 5th is 'b', ...)
  constructor(key) {

    // When no key is provided assumes all letters are shifted to themselves.
    if (key === undefined) key = 'aaaaaaaaaaaaaaaaaaaaaaaaaa';
    
    this._key = key;
  }

  // Decode or Encode a msg using the Caesar cipher. Direction indicates if the key is used to 
  // encode (1) or decode (-1). This correspond to the direction the letters of the msg are shifted
  // using the key.
  _transcribe(msg, direction) {
    
    let codedMsg = [];
    let keyLength = this._key.length;
    
    msg.split('').forEach((char, index) => {
      // the shift for the letter is computed as the distance of the corresponding letter in the
      // key from 'a'. The key is assumed to repeat itself (periodic) if the message is longer than
      // the key.
      // for encoding the letter is shifted up (1), for decoding, it is shifted down (-1).
      // The shift can cause the letter code to go below the code for 'a' or above the code for 'z'.
      // We renormalize the code to be between 'a' and 'z'.
      let shift = keyLength == 0 ? 0 : this._key.charCodeAt(index % keyLength) - A_CODE;
      let codedCharCode = char.charCodeAt(0) + shift * direction;
      if (codedCharCode < A_CODE) codedCharCode += 26;
      if (codedCharCode > Z_CODE) codedCharCode -= 26;
      codedMsg.push(String.fromCharCode(codedCharCode));
    });
    return codedMsg.join('');
  }

  // Encodes the given message using the cipher key.
  encode = (msg) => this._transcribe(msg, 1);

  // Decodes the given message using the cipher key.
  decode = (msg) => this._transcribe(msg, -1);

  // Returns the key associated with the cipher.
  get key() {
    return this._key;
  }
  
}
