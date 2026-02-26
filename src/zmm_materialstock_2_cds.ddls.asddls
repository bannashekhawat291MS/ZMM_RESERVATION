@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR MATERIAL STOCK'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MATERIALSTOCK_2_CDS as select distinct from I_MaterialStock_2
{   
    key Material ,
     Plant ,
     StorageLocation ,
      MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(  MatlWrhsStkQtyInMatlBaseUnit ) as amout
    
    
} 
//where MatlWrhsStkQtyInMatlBaseUnit >= 0 

 group by Material ,
          MaterialBaseUnit ,
        Plant ,
     StorageLocation 
