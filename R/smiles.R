get.smiles <- function(molecule) {
  if (attr(molecule, "jclass") != 'org/openscience/cdk/interfaces/IAtomContainer') {
    stop("Supplied object should be a Java reference to an IAtomContainer")
  }
  smiles <- .jcall('org/guha/rcdk/util/Misc', 'S', 'getSmiles', molecule)
  smiles
}

parse.smiles <- function(smiles) {
  if (!is.character(smiles)) {
    stop("Must supply a SMILES string")
  }
  smiles <- .trim.whitespace(smiles)
  parser <- .jnew('org/openscience/cdk/smiles/SmilesParser')
  mol <- .jcall(parser, 'Lorg/openscience/cdk/Molecule;',
                'parseSmiles', as.character(smiles))
  if (is.null(mol)) return(NA)
  .jcast(mol, 'org/openscience/cdk/interfaces/IAtomContainer')
  
}
