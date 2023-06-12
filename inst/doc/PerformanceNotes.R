## ---- eval=FALSE--------------------------------------------------------------
#  
#  # Bioconductor Packages. Use BiocManager::install()
#  #   Rdisop MetaboCoreUtils ChemmineR ChemmineOB enviPat
#  
#  library(plyr)
#  library(CHNOSZ)
#  library(enviPat)
#  library(MetaboCoreUtils)
#  library(rcdk)
#  library(ChemmineR)
#  library(OrgMassSpecR)
#  library(Rdisop)
#  #library(ChemmineOB)
#  
#  data(isotopes)
#  
#  # original
#  # https://github.com/CDK-R/cdkr/blob/master/rcdk/R/formula.R
#  # get.formula <- function(mf, charge=0) {
#  #
#  #   manipulator <- get("mfManipulator", envir = .rcdk.GlobalEnv)
#  #   if(!is.character(mf)) {
#  #     stop("Must supply a Formula string");
#  #   }else{
#  #     dcob <- .cdkFormula.createChemObject()
#  #     molecularformula <- .cdkFormula.createFormulaObject()
#  #     molecularFormula <- .jcall(manipulator,
#  #                                "Lorg/openscience/cdk/interfaces/IMolecularFormula;",
#  #                                "getMolecularFormula",
#  #                                mf,
#  #                                .jcast(molecularformula,.IMolecularFormula),
#  #                                TRUE);
#  #   }
#  #
#  #   D <- new(J("java/lang/Integer"), as.integer(charge))
#  #   .jcall(molecularFormula,"V","setCharge",D);
#  #   object <- .cdkFormula.createObject(.jcast(molecularFormula,.IMolecularFormula));
#  #   return(object);
#  # }
#  
#  
#  mfManipulator    <- J("org/openscience/cdk/tools/manipulator/MolecularFormulaManipulator")
#  silentchemobject <- J("org.openscience.cdk.silent.SilentChemObjectBuilder")
#  
#  
#  #' Rewrite the formual object and directly access Java
#  #'
#  get.formula2 <- function(mf) {
#  
#    formula <- mfManipulator$getMolecularFormula(
#      "C2H3",
#      silentchemobject$getInstance())
#  
#    mfManipulator$getMass(formula)
#  
#  }
#  
#  #' Add type hints
#  #'
#  get.formula3 <- function(mf) {
#    builderinstance <- .jcall(
#        silentchemobject,
#       "Lorg/openscience/cdk/interfaces/IChemObjectBuilder;",
#       "getInstance")
#  
#    formula  <- .jcall(
#        mfManipulator,
#       "Lorg/openscience/cdk/interfaces/IMolecularFormula;",
#       "getMolecularFormula",
#        mf,
#        builderinstance);
#  
#    mfManipulator$getMass(formula)
#  
#  }
#  
#  
#  #' Add type hints
#  #'
#  get.formula4 <- function(mf) {
#    builderinstance <- .jcall(
#        silentchemobject,
#        "Lorg/openscience/cdk/interfaces/IChemObjectBuilder;",
#        "getInstance")
#  
#    formula  <- .jcall(
#        mfManipulator,
#       "Lorg/openscience/cdk/interfaces/IMolecularFormula;",
#       "getMolecularFormula",
#       mf,
#       builderinstance);
#  
#    .jcall(
#        mfManipulator,
#        "D",
#        "getMass",
#       formula)
#  }
#  
#  
#  
#  benchmark <- microbenchmark::microbenchmark(
#    MetaboCoreUtils = MetaboCoreUtils::calculateMass("C2H6O"),
#    rcdk = rcdk::get.formula("C2H6O", charge = 0)@mass,
#    rcdk2 = get.formula2("C2H6O"),
#    rcdk3 = get.formula3("C2H6O"),
#    rcdk4 = get.formula4("C2H6O"),
#    Rdisop = Rdisop::getMolecule("C2H6O")$exactmass,
#    ChemmineR = ChemmineR::exactMassOB(ChemmineR::smiles2sdf("CCO")),
#    OrgMassSpecR = OrgMassSpecR::MonoisotopicMass(formula = OrgMassSpecR::ListFormula("C2H6O)"), charge = 0),
#  
#    CHNOSZ = CHNOSZ::mass("C2H6O"),
#    enviPat = enviPat::isopattern(isotopes, "C2H6O", charge=FALSE, verbose=FALSE)[[1]][1,1]
#    , times=1000L)
#  
#  
#  masses <- c(
#    MetaboCoreUtils=MetaboCoreUtils::calculateMass("C2H6O"),
#    rcdk=rcdk::get.formula("C2H6O", charge = 0)@mass,
#    Rdisop=Rdisop::getMolecule("C2H6O")$exactmass,
#    #ChemmineR=ChemmineR::exactMassOB(ChemmineR::smiles2sdf("CCO")),
#    OrgMassSpecR=OrgMassSpecR::MonoisotopicMass(formula = OrgMassSpecR::ListFormula("C2H6O)"), charge = 0),
#    CHNOSZ=CHNOSZ::mass("C2H6O"),
#    enviPat=enviPat::isopattern(isotopes, "C2H6O", charge=FALSE, verbose=FALSE)[[1]][1,1]
#  )
#  
#  options(digits=10)
#  t(t(sort(masses)))
#  summary(benchmark)[order(summary(benchmark)[,"median"]) , ]
#  clipr::write_clip(as.data.frame(summary(benchmark)[order(summary(benchmark)[,"median"]) , ] ))

