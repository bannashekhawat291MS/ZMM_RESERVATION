@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_RESERVATION_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_RESERVATION_CDS as select from I_ReservationDocumentItem as A
left outer join I_ReservationDocumentHeader as B on (B.Reservation = A.Reservation)
left outer join I_BusinessUserBasic as C on (C.UserID = B.UserID)
left outer join I_Product as D on (D.Product = A.Product)
left outer join I_ProductTypeText as E on (E.ProductType = D.ProductType and E.Language = 'E')
left outer join I_ProductGroupText_2 as F on ( F.ProductGroup = D.ProductGroup and F.Language = 'E' )
left outer join I_ProductStorageLocationBasic as G on (G.Plant = A.Plant and G.Product = A.Product 
   and (G.StorageLocation = 'ST01' or G.StorageLocation = 'ST02'  or G.StorageLocation = 'ST03'
   or G.StorageLocation = 'ST04'  ) and G.WarehouseStorageBin <> '' )
 left outer join I_ProductDescription_2 as H on ( H.Product = A.Product and H.Language = 'E' )
 left outer join I_ProductPlantBasic as I on (I.Product = A.Product and I.Plant = A.Plant )
 left outer join I_MaterialDocumentItem_2 as J on (J.Reservation = A.Reservation and J.ReservationItem = A.ReservationItem and J.DebitCreditCode = 'H'
 and J.GoodsMovementIsCancelled = '' and ( J.GoodsMovementType = '201' or J.GoodsMovementType = '241' or J.GoodsMovementType = '311' ) )
 
 left outer join ZMM_MATERIALSTOCK_2_CDS as CS on ( CS.Material = A.Product and CS.Plant = A.Plant  and CS.StorageLocation = J.StorageLocation )

{
    key A.Reservation, 
    key A.ReservationItem,
    key max( J.MaterialDocument) as MaterialDocument,
    key A.Product,
    key D.ProductOldID, 
    key A.Plant,
//        J.MaterialDocumentItem,
        A.GoodsMovementType,
        J.StorageLocation,
        A.BaseUnit,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        A.ResvnItmRequiredQtyInBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        A.ResvnItmWithdrawnQtyInBaseUnit,
        J.IssuingOrReceivingPlant,
        J.IssuingOrReceivingStorageLoc,
        B.ReservationDate,
        B.CostCenter,
        C.PersonFullName,
        D.ProductType,
        D.ProductGroup,
        E.MaterialTypeName,
        F.ProductGroupName,
        G.WarehouseStorageBin,
        H.ProductDescription,
        I.ABCIndicator,
        B.AssetNumber,
        max( J.PostingDate ) as PostingDate,
        CS.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        CS.amout  as AMONT,
//        J.Batch ,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       sum( J.QuantityInBaseUnit ) as  QuantityInBaseUnit
        
       
         
        
}
 where   
         ( D.ProductType = 'ROH' or  D.ProductType = 'VERP'  or  D.ProductType = 'ERSA' or  D.ProductType = 'HALB' or  D.ProductType = 'FERT'  or  D.ProductType = 'ZWST' )
//     ( A.StorageLocation = 'ST01' or  A.StorageLocation = 'ST02'  or  A.StorageLocation = 'ST03'
//   or  A.StorageLocation = 'ST04'   )


group by
    A.Reservation,
    A.ReservationItem,
//    J.MaterialDocument,
    A.Product,
    D.ProductOldID,
    A.Plant,
    A.GoodsMovementType,
    J.StorageLocation,
    A.BaseUnit,
    A.ResvnItmRequiredQtyInBaseUnit,
    A.ResvnItmWithdrawnQtyInBaseUnit,
    J.IssuingOrReceivingPlant,
    J.IssuingOrReceivingStorageLoc,
    B.ReservationDate,
    C.PersonFullName,
    D.ProductType,
    D.ProductGroup,
    E.MaterialTypeName,
    F.ProductGroupName,
    G.WarehouseStorageBin,
    H.ProductDescription,
    I.ABCIndicator,
    B.AssetNumber,
    CS.MaterialBaseUnit,
    CS.amout,
    B.CostCenter
//    J.Batch,
//    J.QuantityInBaseUnit
//    J.MaterialDocumentItem

   
        
     
        
