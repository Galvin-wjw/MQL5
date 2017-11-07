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
   long leverage = AccountInfoInteger(ACCOUNT_LEVERAGE);
   
   
      
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
      double account_margin = AccountInfoDouble(ACCOUNT_MARGIN);
      //long symbol_margin = SymbolInfoInteger(symbolName,SYMBOL_TRADE_CALC_MODE);
      double lots = PositionGetDouble(POSITION_VOLUME);
      double symbol_tick = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      
      string firstSymbol = StringSubstr(symbolName,0,3);
      string lastSymbol = StringSubstr(symbolName,3,3);
      
      double symbol_margin;
      ENUM_SYMBOL_CALC_MODE symbol_cal_mode = (ENUM_SYMBOL_CALC_MODE)SymbolInfoInteger(symbolName,SYMBOL_TRADE_CALC_MODE);
      //printf(symbol_cal_mode);
      switch(symbol_cal_mode)
      {
         case SYMBOL_CALC_MODE_FOREX:
            symbol_margin = lots*contract_size/leverage;
            if (firstSymbol != "USD")
               symbol_margin = symbol_margin * symbol_tick;
       
            break;
         case SYMBOL_CALC_MODE_CFD:
            //Lots *ContractSize*MarketPrice*Percentage/100
            break;
         case SYMBOL_CALC_MODE_CFDINDEX:
            //(Lots*ContractSize*MarketPrice)*TickPrice/TickSize
            break;





         
      }
     // double initial_margin = SymbolInfoDouble(symbolName,SYMBOL_MARGIN_INITIAL);
      
      printf("sum:%d,symbol:%s,contract_size:%.2f,volume_min:%.2f,digits:%d,spread:%d,account_margin:%.2f,symbol_margin:%.2f",
      sum,symbolName,contract_size,volume_min,digits,spread,account_margin,symbol_margin);

      index++;
    }
    //printf("leverage:%d",leverage);
    
    ENUM_ACCOUNT_TRADE_MODE account_type=(ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE); 

   //printf(account_type);
   string trade_mode; 
   switch(account_type) 
     { 
      case  ACCOUNT_TRADE_MODE_DEMO: 
         trade_mode="demo"; 
         break; 
      case  ACCOUNT_TRADE_MODE_CONTEST: 
         trade_mode="contest"; 
         break; 
      default: 
         trade_mode="real"; 
         break; 
     } 
    //printf(trade_mode);

  }
//+------------------------------------------------------------------+
