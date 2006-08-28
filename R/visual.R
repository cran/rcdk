.packageName <- "rcdk"

draw.molecule <- function(molecule = NA) {
  if (is.na(molecule)) {
    editor <- .jnew("org/guha/rcdk/draw/Get2DStructureFromJCP")
  } else {
    if (attr(molecule, "jclass") != 'org/openscience/cdk/interfaces/IAtomContainer') {
      stop("Supplied object should be a Java reference to an IAtomContainer")
    }
    editor <- .jnew("org/guha/rcdk/draw/Get2DStructureFromJCP", molecule)
  }
  .jcall(editor, "V", "showWindow")
  molecule <- .jcall(editor, "[Lorg/openscience/cdk/interfaces/IAtomContainer;", "getMolecules")
  return(molecule)
}

## script should be a valid Jmol script string
view.molecule.3d <- function(molecule, ncol = 4, cellx = 200, celly = 200, script = NA) {

  if (class(molecule) != 'character' &&
      class(molecule) != 'list' &&
      class(molecule) != 'jobjRef') {
    stop("Must supply a filename, single molecule object or list of molecule objects")
  }
  
  if (class(molecule) == 'character') {
    molecule <- load.molecules(molecule)
    if (length(molecule) == 1) molecule <- molecule[[1]]
  }

  if (class(molecule) != 'list') { ## single molecule
    if (attr(molecule, "jclass") != 'org/openscience/cdk/interfaces/IAtomContainer') {
      stop("Supplied object should be a Java reference to an IAtomContainer")
    }
    viewer <- .jnew("org/guha/rcdk/view/ViewMolecule3D", molecule)
    .jcall(viewer, 'V', 'show')
    if (!is.na(script)) {
      .jcall(viewer, "V", "setScript", script)
    }
  } else { ## script is not run for the grid case
    array <- .jarray(molecule, contents.class="org/openscience/cdk/interfaces/IAtomContainer")
    v3d <- .jnew("org/guha/rcdk/view/ViewMolecule3DTable", array,
                 as.integer(ncol), as.integer(cellx), as.integer(celly))
    .jcall(v3d, 'V', 'show')    
  }
}

view.molecule.2d <- function(molecule, ncol = 4, cellx = 200, celly = 200) {
  if (class(molecule) != 'character' &&
      class(molecule) != 'list' &&
      class(molecule) != 'jobjRef') {
    stop("Must supply a filename, single molecule object or list of molecule objects")
  }
  
  
  if (class(molecule) == 'character') {
    molecule <- load.molecules(molecule)
    if (length(molecule) == 1) molecule <- molecule[[1]]
  }
  
  if (class(molecule) != 'list') { ## single molecule
    if (attr(molecule, "jclass") != 'org/openscience/cdk/interfaces/IAtomContainer') {
      stop("Supplied object should be a Java reference to an IAtomContainer")
    }    
    v2d <- .jnew("org/guha/rcdk/view/ViewMolecule2D", molecule)
    ret <- .jcall(v2d, "V", "draw")
  } else { ## multiple molecules
    array <- .jarray(molecule, contents.class="org/openscience/cdk/interfaces/IAtomContainer")
    v2d <- .jnew("org/guha/rcdk/view/ViewMolecule2DTable", array,
                 as.integer(ncol), as.integer(cellx), as.integer(celly))
  }
}

## fnames - vector of file names
## cnames - vector of column names 
## datatable - data.frame of values associated with a structure
##
## The number of column names should be 1+ncol(datatable), since
## the final table will have a column showing the structures

view.molecule.table <- function(fnames, cnames, datatable) {
  if (!is.matrix(datatable) && !is.data.frame(datatable)) {
    stop("datatable must be a matrix or data.frame")
  }

  if (length(fnames) != nrow(datatable)) {
    stop("The number of rows in datatable must be the same as the number of files to view")
  }
  
  if (length(cnames) != ncol(datatable)+1) {
    warning("Column names should be included for the final table. Using default names")
    cnames <- paste("Column", 1:(ncol(datatable)+1), sep='')
  }


  ## we need to convert the R vectors to Java arrays
  ## and the datatable data.frame to an Object[][]
  farr = .JavaArrayConstructor( "java.lang.String", dim=c(length(fnames)))
  for (i in 1:length(fnames)) {
    .JavaSetArrayElement(farr, as.character(fnames[i]), i)
  }

  carr = .JavaArrayConstructor( "java.lang.String", dim=c(length(cnames)))
  for (i in 1:length(cnames)) {
    .JavaSetArrayElement(carr, as.character(cnames[i]), i)
  }

  xval.arr = .JavaArrayConstructor( "java.lang.Object", dim=c(nrow(datatable),0))
  
  for (i in 1:nrow(datatable)) {
    .JavaSetArrayElement(xval.arr, .JavaArrayConstructor("java.lang.Object", dim=c(ncol(datatable))), i)
    for (j in 1:ncol(datatable)) {
      if (is.integer(datatable[i,j])) {
        obj <- .JavaConstructor("Integer", datatable[i,j])
        ##.JavaSetArrayElement(xval.arr, as.integer(datatable[i,j]), i,j)
        .JavaSetArrayElement(xval.arr, obj, i,j)
      }
      else if (is.numeric(datatable[i,j])) {
        obj <- .JavaConstructor("Double", datatable[i,j])
        ##.JavaSetArrayElement(xval.arr, as.numeric(datatable[i,j]), i,j)
        .JavaSetArrayElement(xval.arr, obj, i,j)
      }
      else if (is.character(datatable[i,j])) {
        .JavaSetArrayElement(xval.arr, as.character(datatable[i,j]), i,j)
      }
      
    }
  }
  obj <- .JNew("ViewMolecule3DTable", farr, carr, xval.arr)
}



