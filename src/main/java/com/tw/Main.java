package com.tw;

import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

import com.mifmif.common.regex.Generex;
import com.mifmif.common.regex.util.Iterator;

public class Main {
	
	public static void checkSymbol(String data,String symbol) {
		if(data.indexOf(symbol)!=-1) {
			if(data.indexOf("\\"+symbol)==-1) {
				System.out.println("發現為跳脫符號，可能造成效能異常之表示式" + symbol + ",自動結束程式。");
				System.exit(0);
			}
		}
	}
	
	public static void main(String[] args) throws Exception {
					
		File reg_file = new File("regex_input.txt");		
		Scanner myReader = new Scanner(reg_file);		
		FileWriter myWriter = new FileWriter("HostNames.txt");
		
		while (myReader.hasNextLine()) {			
			String data = myReader.nextLine();						
			System.out.println("執行表示式: " + data);
			
			checkSymbol(data,".");
			checkSymbol(data,"+");
			checkSymbol(data,"*");
			
			Generex generex = new Generex(data);
			Iterator iterator = generex.iterator();
			while (iterator.hasNext()) {
				String next = iterator.next();
				System.out.println(next);
				myWriter.write(next+"\n");
			}			
		}
		
		myReader.close();
		myWriter.close();
	}
}
