get.desc.values <- function(dval) {
  nval <- numeric()
  result <- .jcall(dval, "Lorg/openscience/cdk/qsar/result/IDescriptorResult;", "getValue")
  methods <- .jmethods(result)

  if ("public double org.openscience.cdk.qsar.result.DoubleArrayResult.get(int)" %in% methods) {
    result <- .jcast(result, "org/openscience/cdk/qsar/result/DoubleArrayResult")
    len <- .jcall(result, "I", "size")
    for (i in 1:len) nval[i] <- .jcall(result, "D", "get", as.integer(i-1))
  } else if ("public int org.openscience.cdk.qsar.result.IntegerArrayResult.get(int)" %in% methods) {
    result <- .jcast(result, "org/openscience/cdk/qsar/result/IntegerArrayResult")    
    len <- .jcall(result, "I", "size")
    for (i in 1:len) nval[i] <- .jcall(result, "I", "get", as.integer(i-1))    
  }  else if ("public int org.openscience.cdk.qsar.result.IntegerResult.intValue()" %in% methods) {
    result <- .jcast(result, "org/openscience/cdk/qsar/result/IntegerResult")    
    nval <- .jcall(result, "I", "intValue")
  } else if ("public double org.openscience.cdk.qsar.result.DoubleResult.doubleValue()" %in% methods) {
    result <- .jcast(result, "org/openscience/cdk/qsar/result/DoubleResult")    
    nval <- .jcall(result, "D", "doubleValue")    
  }
  
  nval
}

get.desc.engine <- function(type = 'molecular') {
  if (!(type %in% c('molecular', 'atomic', 'bond'))) {
    stop('type must bond, molecular or atomic')
  }
  type <- match(type, c('atomic', 'bond', 'molecular'))
  dengine <- .jnew('org/openscience/cdk/qsar/DescriptorEngine', as.integer(type))
  attr(dengine, 'descType') <- type
  pkg <-   pkg <- c('org.openscience.cdk.qsar.descriptors.atomic',
           'org.openscience.cdk.qsar.descriptors.bond',
           'org.openscience.cdk.qsar.descriptors.molecular')[ type ]
  attr(dengine, 'descPkg') <- pkg
  dengine
}
  
get.desc.classnames <- function(dengine) {
  if (attr(dengine, "jclass") != "org/openscience/cdk/qsar/DescriptorEngine") {
    stop("Must supply a DescriptorEngine object")
  }
  
  type <- attr(dengine, "descType")
  pkg <- attr(dengine, "descPkg")
  
  cn <- .jcall(dengine, 'Ljava/util/List;', 'getDescriptorClassNames')
  size <- .jcall(cn, "I", "size")
  cnames <- list()
  for (i in 1:size) cnames[[i]] <- .jsimplify(.jcast(.jcall(cn, "Ljava/lang/Object;", "get", as.integer(i-1)), "java/lang/String"))
  #cnames <- gsub(paste(pkg, '.', sep='',collapse=''), '',  unlist(cnames))
  unique(unlist(cnames)  )
}

eval.desc <- function(molecule, which.desc) {
  if (attr(molecule, "jclass") != "org/openscience/cdk/interfaces/IAtomContainer") {
    stop("molecule must be an IAtomContainer")
  }
  desc <- .jnew(which.desc)
  descval <- .jcall(desc, "Lorg/openscience/cdk/qsar/DescriptorValue;", "calculate", molecule)
  vals <- get.desc.values(descval)
  vals
}
