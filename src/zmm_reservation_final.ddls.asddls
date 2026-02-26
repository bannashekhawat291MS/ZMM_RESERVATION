@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_RESERVATION_FINAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_RESERVATION_FINAL
  as select from    ZMM_RESERVATION_CDS as A
    left outer join I_CostCenterText    as B   on(
        A.CostCenter   = B.CostCenter
        and B.Language = 'E'
      )
//    left outer join ZBAGNO_CDS_MB51     as PAC on(
//      PAC.BatchNo = A.Batch
//    )
{

             @UI.lineItem             : [{ position: 10 }]
             @EndUserText.label       : 'Issue Slip'
             @UI.selectionField       : [{position: 10 }]
  key        A.Reservation,

             @UI.lineItem             : [{ position: 20 }]
             @EndUserText.label       : 'Issue Slip Item'
  key        A.ReservationItem,

             @UI.lineItem             : [{ position: 30 }]
             @EndUserText.label       : 'Item'
  key        A.Product,


             @UI.lineItem             : [{ position: 160 }]
             @EndUserText.label       : 'OldID'
  key        A.ProductOldID,



             @UI.lineItem             : [{ position: 50 }]
             @EndUserText.label       : 'Plant'
  key        A.Plant,




             @UI.lineItem             : [{ position: 40 }]
             @EndUserText.label       : 'GoodsMovementType'
  key        A.GoodsMovementType,


             @UI.lineItem             : [{ position: 60 }]
             @EndUserText.label       : 'StorageLocation'
  key        A.StorageLocation,

             @UI.lineItem             : [{ position: 70 }]
             @EndUserText.label       : 'BaseUnit'
  key        A.BaseUnit,

             @UI.lineItem             : [{ position: 80 }]
             @EndUserText.label       : 'Required Qty'
             @Aggregation.default:  #SUM
             // @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  key        cast(sum(A.ResvnItmRequiredQtyInBaseUnit) as abap.dec( 20, 3 ) )  as Qty,
             // ResvnItmRequiredQtyInBaseUnit,

             @UI.lineItem             : [{ position: 90 }]
             @EndUserText.label       : 'Delivered qty'
             @Aggregation.default:  #SUM
             // @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  key        cast(sum(A.ResvnItmWithdrawnQtyInBaseUnit) as abap.dec( 20, 3 ) ) as WithdrawnQty,
//  key        cast(sum(A.QuantityInBaseUnit) as abap.dec( 20, 3 ) ) as WithdrawnQty,
             // ResvnItmWithdrawnQtyInBaseUnit,

             @UI.lineItem             : [{ position: 100 }]
             @EndUserText.label       : 'IssuingOrReceivingPlant'
  key        A.IssuingOrReceivingPlant,

             @UI.lineItem             : [{ position: 110 }]
             @EndUserText.label       : 'IssuingOrReceivingStorageLoc'
  key        A.IssuingOrReceivingStorageLoc,

             @UI.lineItem             : [{ position: 120 }]
             @EndUserText.label       : 'Issue Slip Date'
  key        A.ReservationDate,

             @UI.lineItem             : [{ position: 130 }]
             @EndUserText.label       : 'User'
  key        A.PersonFullName,

             @UI.lineItem             : [{ position: 140 }]
             @EndUserText.label       : 'Item Type'
  key        A.ProductType,

             @UI.lineItem             : [{ position: 150 }]
             @EndUserText.label       : 'Item Group'
  key        A.ProductGroup,




             @UI.lineItem             : [{ position: 170 }]
             @EndUserText.label       : 'Item TypeName'
  key        A.MaterialTypeName,

             @UI.lineItem             : [{ position: 180 }]
             @EndUserText.label       : 'Item GroupName'
  key        A.ProductGroupName,

             @UI.lineItem             : [{ position: 190 }]
             @EndUserText.label       : 'StorageBin'
  key        A.WarehouseStorageBin,

             @UI.lineItem             : [{ position: 200 }]
             @EndUserText.label       : 'Item Name'
  key        A.ProductDescription,

             @UI.lineItem             : [{ position: 210 }]
             @EndUserText.label       : 'Emergency Flag'
  key        A.ABCIndicator,

             @UI.lineItem             : [{ position: 220 }]
             @EndUserText.label       : 'AssetNumber'
  key        A.AssetNumber,

             //         @UI.lineItem             : [{ position: 230 }]
             //         @EndUserText.label       : 'Batch'
             //    key     Batch,
             //
             @UI.lineItem             : [{ position: 240 }]
             @EndUserText.label       : 'PostingDate'
             @UI.selectionField       : [{position: 20 }]
  key        A.PostingDate,

             @UI.lineItem             : [{ position: 250 }]
             @EndUserText.label       : 'MaterialDocument'
  key        A.MaterialDocument,

             //          @UI.lineItem             : [{ position: 260 }]
             //         @EndUserText.label       : 'MaterialDocumentItem'
             //     key    MaterialDocumentItem  ,



             @UI.lineItem             : [{ position: 270 }]
             @EndUserText.label       : 'MaterialBaseUnit'
  key        A.MaterialBaseUnit,


             @UI.lineItem             : [{ position: 290 }]
             @EndUserText.label       : 'Cost Center'
  key        A.CostCenter,


             @UI.lineItem             : [{ position: 291 }]
             @EndUserText.label       : 'Cost Center Name'
  key        B.CostCenterName,

//
//             @UI.lineItem             : [{ position: 295 }]
//             @EndUserText.label       : 'Batch'
//  key        A.Batch,


             @UI.lineItem             : [{ position: 280 }]
             @EndUserText.label       : 'Current Stock'
             //      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
             @Aggregation.default:  #SUM
             //           cast(sum(MatlWrhsStkQtyInMatlBaseUnit) as abap.dec( 20, 3 ) ) as CurrentStock
             case when A.AMONT < 0 then cast(0 as abap.dec(20,3))
             //          then '0'
             else
              cast(sum(A.AMONT) as abap.dec( 20, 3 ) )
              end                                                              as CurrentStock


             //         key  MatlWrhsStkQtyInMatlBaseUnit

//             @UI.lineItem   : [{ position: 322 }]
//             @UI.identification: [{position: 322}]
//             @EndUserText.label: 'Pack Size'
//             cast( PAC.Packsize as abap.dec( 13, 2 ))                          as Packsize

}

//where A.GoodsMovementType <> '261'

group by
  A.Reservation,
  A.ReservationItem,
  A.Product,
  A.GoodsMovementType,
  A.Plant,
  A.StorageLocation,
  A.BaseUnit,
  A.IssuingOrReceivingPlant,
  A.IssuingOrReceivingStorageLoc,
  A.ResvnItmWithdrawnQtyInBaseUnit,
  A.ResvnItmRequiredQtyInBaseUnit,
  A.ReservationDate,
  A.PersonFullName,
  A.ProductType,
  A.ProductGroup,
  A.ProductOldID,
  A.MaterialTypeName,
  A.ProductGroupName,
  A.WarehouseStorageBin,
  A.ProductDescription,
  A.ABCIndicator,
  A.AssetNumber,
  //     Batch,
  A.PostingDate,
  A.MaterialDocument,
  //     MaterialDocumentItem,
  A.MaterialBaseUnit,
  A.AMONT,
  A.CostCenter,
//  A.Batch,
  B.CostCenterName
//  PAC.Packsize
 
//     MatlWrhsStkQtyInMatlBaseUnit
