//+------------------------------------------------------------------+
//|                                                       margin.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
 //  action = ORDER_TYPE_BUY,
  // string symbol,
  // double volume = 0.01;
   
   
   
   int sum = PositionsTotal();
   int index = 0;
   string symbolName = "";
      
   while(index < sum)
   {
      symbolName = PositionGetSymbol(index);
    //  double price= SymbolInfoDouble(symbolName,SYMBOL_LAST);   
    //  int margin = OrderCalcMargin(ORDER_TYPE_BUY,symbolName,volume,price);
      double contract_size = SymbolInfoDouble(symbolName,SYMBOL_TRADE_CONTRACT_SIZE);
      double volume_min = SymbolInfoDouble(symbolName,SYMBOL_VOLUME_MIN);
    //  double volume_max = SymbolInfoDouble(symbolName,);
      int digits = SymbolInfoInteger(symbolName,SYMBOL_DIGITS);
      int spread = SymbolInfoInteger(symbolName,SYMBOL_SPREAD);
      double margin = SymbolInfoDouble(symbolName,SYMBOL_MARGIN_INITIAL);
      
      printf("sum:%d,symbol:%s,contract_size:%.2f,volume_min:%.2f,digits:%d,spread:%d",
      sum,symbolName,contract_size,margin,digits,spread);

      index++;
    }
  }
//+------------------------------------------------------------------+
