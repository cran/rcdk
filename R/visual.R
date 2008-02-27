.packageName <- "rcdk"

## draw.molecule <- function(molecule = NA) {
##   if (is.na(molecule)) {
##     editor <- .jnew("org/guha/rcdk/draw/Get2DStructureFromJCP")
##   } else {
##     if (attr(molecule, "jclass") != 'org/openscience/cdk/interfaces/IAtomContainer') {
##       stop("Supplied object should be a Java reference to an IAtomContainer")
##     }
##     editor <- .jnew("org/guha/rcdk/draw/Get2DStructureFromJCP", molecule)
##   }
##   .jcall(editor, "V", "showWindow")
##   molecule <- .jcall(editor, "[Lorg/openscience/cdk/interfaces/IAtomContainer;", "getMolecules")
##   return(molecule)
## }

## script should be a valid Jmol script string
## view.molecule.3d <- function(molecule, ncol = 4, cellx = 200, celly = 200, script = NA) {

##   if (class(molecule) != 'character' &&
##       class(molecule) != 'list' &&
##       class(molecule) != 'jobjRef') {
##     stop("Must supply a filename, single molecule object or list of molecule objects")
##   }
  
##   if (class(molecule) == 'character') {
##     molecule <- load.molecules(molecule)
##     if (length(molecule) == 1) molecule <- molecule[[1]]
##   }

##   if (class(molecule) != 'list') { ## single molecule
##     if (attr(molecule, "jclass") != 'org/openscience/cdk/interfaces/IAtomContainer') {
##       stop("Supplied object should be a Java reference to an IAtomContainer")
##     }
##     viewer <- .jnew("org/guha/rcdk/view/ViewMolecule3D", molecule)
##     .jcall(viewer, 'V', 'show')
##     if (!is.na(script)) {
##       .jcall(viewer, "V", "setScript", script)
##     }
##   } else { ## script is not run for the grid case
##     array <- .jarray(molecule, contents.class="org/openscience/cdk/interfaces/IAtomContainer")
##     v3d <- .jnew("org/guha/rcdk/view/ViewMolecule3DTable", array,
##                  as.integer(ncol), as.integer(cellx), as.integer(celly))
##     .jcall(v3d, 'V', 'show')    
##   }
## }

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

.view.molecule.table <- function(fnames, cnames, datatable) {
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
  farr <- .jarray(fnames)
  carr <- .jarray(cnames)
  
  rows <- list()
  for (i in 1:nrow(datatable)) {
    row <- list()
    
    ## for a given row we have to construct a Object[] and add
    ## it to our list
    for (j in 1:ncol(datatable)) {
      if (is.numeric(datatable[i,j])) {
        row[j] <- .jnew("java/lang/Double", datatable[i,j])
      }
      else if (is.character(datatable[i,j])) {
        row[j] <- .jnew("java/lang/String", as.character(datatable[i,j]))
      }
    }
    rows[[i]] <- .jarray(row, "java/lang/Object")
  }

  ## now make our object table
  xval.arr <- .jarray(rows, "[Ljava/lang/Object")
  obj <- .jnew("org/guha/rcdk/view/ViewMolecule3DDataTable",
               farr, carr,xval.arr)

}



