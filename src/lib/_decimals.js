function prepareName(isSigned, bits) {
  let name = "Decimal";
  if (bits != "128") {
    name += bits;
  }

  if (isSigned) {
    name = `Signed${name}`;
  }

  return name;
}

function prepareLink(isSigned, bits) {
  return `https://docs.rs/cosmwasm-std/latest/cosmwasm_std/struct.${prepareName(isSigned, bits)}.html`;
}

export { prepareName, prepareLink };
