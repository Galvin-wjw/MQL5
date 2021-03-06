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
      double volume_max = SymbolInfoDouble(symbolName,SYMBOL_VOLUME_MAX);
      int digits = SymbolInfoInteger(symbolName,SYMBOL_DIGITS);
      int spread = SymbolInfoInteger(symbolName,SYMBOL_SPREAD);
      double account_margin = AccountInfoDouble(ACCOUNT_MARGIN);
      //long symbol_margin = SymbolInfoInteger(symbolName,SYMBOL_TRADE_CALC_MODE);
      double lots = PositionGetDouble(POSITION_VOLUME);
      double symbol_tick = SymbolInfoDouble(symbolName,SYMBOL_ASK);
      
      long time = PositionGetInteger(POSITION_TIME_MSC);
     // printf(time);
      
      
      string firstSymbol = StringSubstr(symbolName,0,3);
      string lastSymbol = StringSubstr(symbolName,3,5);
      
     // printf("%s,%s",firstSymbol,lastSymbol);
     // bool test = 
      double symbol_margin = 0;
      string symbol2 = "";  //存放交叉盘转美元的品种
      bool a;//存放布尔值
      double tick_size ; //最小价格改变
      double tick_price;  //点值
      
      ENUM_SYMBOL_CALC_MODE symbol_cal_mode = (ENUM_SYMBOL_CALC_MODE)SymbolInfoInteger(symbolName,SYMBOL_TRADE_CALC_MODE);
      //printf(symbol_cal_mode);
      switch(symbol_cal_mode)
      {
         case SYMBOL_CALC_MODE_FOREX:
            if (firstSymbol == "USD")
            {
               //printf(firstSymbol);
               symbol_margin = lots*contract_size/leverage;
            }
            else if (lastSymbol == "USD"){
               //printf(lastSymbol);
               symbol_margin = lots*contract_size/leverage * symbol_tick;
               }
            else {
            
               symbol2 = "USD"+firstSymbol;
               
               a = SymbolSelect(symbol2,true);
   
               if(a)
               {
                  symbol_tick = SymbolInfoDouble(symbol2,SYMBOL_ASK);
                  printf("transfer symbol: %s,tick: %.4f",symbol2,symbol_tick);
                  symbol_margin = lots*contract_size/leverage / symbol_tick;
               }
               else
               {
                  symbol2 = firstSymbol + "USD";
                  symbol_tick = SymbolInfoDouble(symbol2,SYMBOL_ASK);
                  printf("transfer symbol: %s,tick: %.4f",symbol2,symbol_tick);
                  symbol_margin = lots*contract_size/leverage * symbol_tick;
                  
               }
            }
            break;
         case SYMBOL_CALC_MODE_CFD:
            symbol_margin = lots * contract_size * symbol_tick; 
            //Lots *ContractSize*MarketPrice*Percentage/100
            break;
         case SYMBOL_CALC_MODE_CFDINDEX:
            
            tick_size = SymbolInfoDouble(symbolName,SYMBOL_TRADE_TICK_SIZE); 
            
            tick_price  = SymbolInfoDouble(symbolName,SYMBOL_POINT);
            symbol_margin = lots * contract_size *symbol_tick *tick_price / tick_size;
            //(Lots*ContractSize*MarketPrice)*TickPrice/TickSize
            break;
         
      }
  
      
      printf("sum:%d,symbol:%s,contract_size:%.2f,volume_min:%.2f,volume_max:%.2f,digits:%d,spread:%d,account_margin:%.2f,symbol_margin:%.2f",
      sum,symbolName,contract_size,volume_min,volume_max,digits,spread,account_margin,symbol_margin);

      index++;
    }
    //printf("leverage:%d",leverage);
  
  }
//+------------------------------------------------------------------+
