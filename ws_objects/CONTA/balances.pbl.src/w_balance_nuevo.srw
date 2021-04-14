$PBExportHeader$w_balance_nuevo.srw
forward
global type w_balance_nuevo from w_int_con_empresa
end type
type pb_2 from upb_salir within w_balance_nuevo
end type
type em_fechadesde from u_em_campo within w_balance_nuevo
end type
type gb_22 from groupbox within w_balance_nuevo
end type
type gb_1 from groupbox within w_balance_nuevo
end type
type cb_consulta from u_boton within w_balance_nuevo
end type
type em_fechahasta from u_em_campo within w_balance_nuevo
end type
type st_1 from statictext within w_balance_nuevo
end type
type gb_2 from groupbox within w_balance_nuevo
end type
type pb_imprimir_preli from picturebutton within w_balance_nuevo
end type
type dw_1 from datawindow within w_balance_nuevo
end type
type dw_cursord from datawindow within w_balance_nuevo
end type
type dw_cursorh from datawindow within w_balance_nuevo
end type
type dw_listado from datawindow within w_balance_nuevo
end type
type uo_balance from u_em_campo_2 within w_balance_nuevo
end type
type cbx_1 from checkbox within w_balance_nuevo
end type
type cbx_2 from checkbox within w_balance_nuevo
end type
type cbx_3 from checkbox within w_balance_nuevo
end type
end forward

global type w_balance_nuevo from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3621
integer height = 2304
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_22 gb_22
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
gb_2 gb_2
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
dw_cursord dw_cursord
dw_cursorh dw_cursorh
dw_listado dw_listado
uo_balance uo_balance
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
end type
global w_balance_nuevo w_balance_nuevo

type variables
integer anyo

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_filtro (datawindow dw_data)
public function decimal f_saldo_formula (string formu, string subgrup_nombre[], decimal subgrup_saldo[], string grupo_nombre[], ref decimal grupo_saldo[], decimal subgrup_saldo_ant[], ref decimal grupo_saldo_ant[], long posicion, ref decimal retorno_anterior, ref string calculado_grupo[])
public function boolean f_existe_cuenta (string arg_empresa, string arg_balance, string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_cuenta)
end prototypes

public subroutine f_cargar (datawindow dw_data);long registros,i,j,k,linea,indice_subgrupo,indice_grupo
long cd,ch,cc,n,orden,max
string bloque,grupo,subgrupo,cuenta,formula
string fd_ant,fh_ant
datetime fdesde,fhasta,fdesde_anterior,fhasta_anterior
string sel1,sel2
dec defecto,saldo,saldo_anterior

string calculado_grupo[]

string grupo_nombre[],subgrup_nombre[]
dec grupo_saldo[],subgrup_saldo[]
dec grupo_saldo_anterior[],subgrup_saldo_anterior[]
int tipo,l
datastore d1,d2


dw_data.SetTransObject(sqlca)
dw_data.reset()
Setpointer(HourGlass!)

dw_data.setredraw(false)


fdesde=datetime(date(em_fechadesde.text))
fhasta=datetime(date(em_fechahasta.text))


fd_ant = string(day(date(fdesde))) +"/" + string(month(date(fdesde))) + "/" + string(year(date(fdesde)) - 1)
fh_ant = string(day(date(fhasta))) +"/" + string(month(date(fhasta))) + "/" + string(year(date(fhasta)) - 1)

fdesde_anterior = datetime(date(fd_ant))
fhasta_anterior = datetime(date(fh_ant))

dw_data.retrieve(codigo_empresa,fdesde,fhasta,uo_balance.em_codigo.text)


cd=dw_cursord.retrieve(codigo_empresa,uo_balance.em_codigo.text,'D')
ch=dw_cursorh.retrieve(codigo_empresa,uo_balance.em_codigo.text,'H')

orden = 0
for l = 1 to 2
	if l = 1 then 
		bloque = "D"
		max = cd
	end if
	
	if l = 2 then
		bloque = "H"
		max = ch
	end if
	
	for i=1 to max
		f_mensaje_proceso("Calculando saldo bloque " + bloque,i,cd)
		
		if l = 1 then
			grupo		=	trim(dw_cursord.getitemstring(i,"grupo"))
			titulo 	= 	trim(dw_cursord.getitemstring(i,"titulo"))
			formula	=	trim(dw_cursord.getitemstring(i,"formula"))
		end if
		
		if l = 2 then
			grupo		=	trim(dw_cursorh.getitemstring(i,"grupo"))
			titulo 	= 	trim(dw_cursorh.getitemstring(i,"titulo"))
			formula	=	trim(dw_cursorh.getitemstring(i,"formula"))
		end if
		
		indice_grupo = upperbound(grupo_nombre) + 1
		grupo_nombre[indice_grupo] = grupo
		grupo_saldo[indice_grupo] = 0
		grupo_saldo_anterior[indice_grupo] = 0
		
		linea = dw_data.insertrow(0)
				
		dw_data.setitem(linea,"grupo",grupo)
		dw_data.setitem(linea,"nombre_grupo",titulo)
		dw_data.setitem(linea,"tipo",1)
		dw_data.setitem(linea,"bloque",bloque)
		orden = orden + 1 
		dw_data.setitem(linea,"orden",orden)
		dw_data.setitem(linea,"visible",1)
			
		if formula <> "" then
			// Si el grupo tiene formula no debe verse el saldo del grupo
			// sino el de la formula
			dw_data.setitem(linea,"visible",0)
			
			linea = dw_data.insertrow(0)
				
			dw_data.setitem(linea,"grupo",grupo)
			dw_data.setitem(linea,"formula",formula)
			dw_data.setitem(linea,"tipo",2)
			dw_data.setitem(linea,"bloque",bloque)
			orden = orden + 1 
			dw_data.setitem(linea,"orden",orden)
			dw_data.setitem(linea,"visible",1)
			
			calculado_grupo[indice_grupo] = "N"
		else
			calculado_grupo[indice_grupo] = "S"
			
		end if	
		
		
		sel1 = 	" Select * from contabalsubgrup " + &
					" where contabalsubgrup.empresa 	= 	'" + codigo_empresa + "'" + &
					" and contabalsubgrup.codbal 		=	'" + uo_balance.em_codigo.text + "'" +&
					" and contabalsubgrup.bloque		=	'" + bloque + "'" + &
					" and contabalsubgrup.grupo		=	'"	+	grupo + "'" + &
					" order by orden"
		
//		d1 = f_cargar_cursor(sel1)
		f_cargar_cursor_nuevo(sel1, d1)
		
		for j = 1 to d1.rowcount()
			subgrupo =  trim(d1.getitemstring(j,"subgrupo"))
			
			indice_subgrupo = upperbound(subgrup_nombre)+ 1 
			subgrup_nombre[indice_subgrupo] = subgrupo
			subgrup_saldo[indice_subgrupo] = 0
			subgrup_saldo_anterior[indice_subgrupo] = 0
			
			titulo	=	trim(d1.getitemstring(j,"titulo"))
			linea = dw_data.insertrow(0)
				
			dw_data.setitem(linea,"grupo",grupo)
			dw_data.setitem(linea,"subgrupo",subgrupo)
			dw_data.setitem(linea,"nombre_subgrupo",titulo)
			dw_data.setitem(linea,"tipo",3)
			dw_data.setitem(linea,"bloque",bloque)
			dw_data.setitem(linea,"visible",1)
			
			orden = orden + 1 
			dw_data.setitem(linea,"orden",orden)
			
			sel2 = " Select * from contaballin " + &
					" where contaballin.empresa 	= 	'" + codigo_empresa + "'" + &
					" and contaballin.codbal 		=	'" + uo_balance.em_codigo.text + "'" +&
					" and contaballin.bloque			=	'" + bloque + "'" + &
					" and contaballin.grupo			=	'"	+	grupo + "'" + &
					" and contaballin.subgrupo		=	'"	+	subgrupo + "'" + &
					" order by orden"
			
			//d2 = f_cargar_cursor(sel2)
			f_cargar_cursor_nuevo(sel2, d2)
			boolean existe_cuenta
			for k = 1 to d2.rowcount()
				cuenta = trim(d2.getitemstring(k,"cuenta"))	
				titulo = trim(d2.getitemstring(k,"titulo"))	
				defecto=	d2.getitemnumber(k,"importe")
				
				// Comprobamos si existe la cuenta
				// Una cuenta puede estar en el bloque debe y haber
				// pero sólo puede tener saldo en uno de los casos 
				existe_cuenta = f_existe_cuenta(codigo_empresa,uo_balance.em_codigo.text,bloque,grupo,subgrupo,cuenta) 
					
				
				//Cálculo del saldo de la cuenta si no tiene saldo defecto
				if isnull(defecto) or defecto=0 then		 	
					// Si la cuenta es la 129 y no tiene saldo ponemos la 6 - la 7
					if cuenta = "129" then
						
						saldo=f_saldo_cuenta_balance(anyo,codigo_empresa,cuenta,fdesde,fhasta)		
						saldo_anterior = f_saldo_cuenta_balance(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)														
						
						
						dec saldo_6,saldo_7,saldo_ant_6,saldo_ant_7					
						saldo_6 = f_saldo_cuenta_balance(anyo,codigo_empresa,"6",fdesde,fhasta)			
						saldo_7 = f_saldo_cuenta_balance(anyo,codigo_empresa,"7",fdesde,fhasta)								
			
						saldo = saldo + saldo_6 + saldo_7
						
						
						// Si la 129 en el ejercicio ant no tiene saldo
						
						saldo_ant_6 = f_saldo_cuenta_balance(anyo - 1,codigo_empresa,"6",fdesde_anterior,fhasta_anterior)								
						saldo_ant_7 = f_saldo_cuenta_balance(anyo - 1,codigo_empresa,"7",fdesde_anterior,fhasta_anterior)															
							
						saldo_anterior = saldo_anterior + saldo_ant_6 + saldo_ant_7
																	
					else
						saldo=f_saldo_cuenta_balance(anyo,codigo_empresa,cuenta,fdesde,fhasta)		
						saldo_anterior = f_saldo_cuenta_balance(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)								
					
					end if
					
				else
					saldo = defecto				
				end if								
				
				// Si está la cuenta más de una vez (una vez en el debe y
				// otra en el haber ) sólo debe aparecer 
				// una vez en el bloque donde tenga saldo positivo 
												
				if existe_cuenta then					
					if bloque = "D" then	
						if saldo < 0 then saldo = 0
						if saldo_anterior < 0 then saldo_anterior = 0										
					end if	
					if bloque = "H" then	
						if saldo > 0 then saldo = 0
						if saldo_anterior > 0 then saldo_anterior = 0										
					end if	
				end if
				
				// Si la cuenta está en el haber se cambia el signo
				if bloque = "H" then
					saldo = (- 1) * saldo		
					saldo_anterior = (- 1) * saldo_anterior			
				end if
				
				// acumulamos en el grupo y subgrupo
				grupo_saldo[indice_grupo] = grupo_saldo[indice_grupo] + saldo							
				grupo_saldo_anterior[indice_grupo] = grupo_saldo_anterior[indice_grupo] + saldo_anterior 											
				subgrup_saldo[indice_subgrupo] = subgrup_saldo[indice_subgrupo] + saldo			
				subgrup_saldo_anterior[indice_subgrupo] = subgrup_saldo_anterior[indice_subgrupo] + saldo_anterior			
				
				// Insertamos las cuentas
				linea = dw_data.insertrow(0)
				
				dw_data.setitem(linea,"grupo",grupo)
				dw_data.setitem(linea,"subgrupo",subgrupo)
				dw_data.setitem(linea,"cuenta",cuenta)
				dw_data.setitem(linea,"nombre_cuenta",titulo)
				dw_data.setitem(linea,"saldo",saldo)
				dw_data.setitem(linea,"saldo_anterior",saldo_anterior)
				dw_data.setitem(linea,"tipo",4)
				dw_data.setitem(linea,"bloque",bloque)
				dw_data.setitem(linea,"visible",1)
				orden = orden + 1 
				dw_data.setitem(linea,"orden",orden)
			next
		next
	next
next

// Se añade el saldo de subgrupo y grupos
for i = 1 to dw_data.rowcount()
	f_mensaje_proceso("Calculando saldo de grupos ",i,dw_data.rowcount())
	tipo = dw_data.getitemnumber(i,"tipo")
	// Es un grupo sin formula. El valor para el grupo es la suma de las cuentas
	if tipo = 1 then		
		grupo = trim(dw_data.getitemstring(i,"grupo"))
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				saldo = grupo_saldo[j]
				saldo_anterior = grupo_saldo_anterior[j]
				exit
			end if 
		next	
				
		dw_data.setitem(i,"saldo",saldo)
		dw_data.setitem(i,"saldo_grupo",saldo)
		dw_data.setitem(i,"saldo_anterior",saldo_anterior)
		dw_data.setitem(i,"saldo_grupo_ant",saldo_anterior)
	end if
	
	// Grupo con formula. Su valor depende del saldo de otros grupos o
	// subgrupos. Es posible que no se pueda calcular ahora debido
	// a que falta calcular el saldo de alguno de los que lo componen.
	// Si ahora no se puede calcular se hará después.
	if tipo = 2 then		
		long posicion
		formula = trim(dw_data.getitemstring(i,"formula"))
		grupo = trim(dw_data.getitemstring(i,"grupo")			)
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				posicion = j
				exit
			end if 
		next
		
		
		saldo = f_saldo_formula(formula,subgrup_nombre,subgrup_saldo,grupo_nombre,grupo_saldo,subgrup_saldo_anterior,grupo_saldo_anterior,posicion,saldo_anterior,calculado_grupo[])						
		dw_data.setitem(i,"saldo",saldo)
		dw_data.setitem(i,"saldo_grupo",saldo)
		dw_data.setitem(i,"saldo_grupo_ant",saldo_anterior)
		dw_data.setitem(i,"saldo_anterior",saldo_anterior)
	end if
	
	
	// Es un subgrupo. Su saldo siempre es la suma de las cuentas que lo componen
	if	tipo = 3 then 
		subgrupo = trim(dw_data.getitemstring(i,"subgrupo"))
		for j = 1 to upperbound(subgrup_nombre) 
			if subgrup_nombre[j] = subgrupo then
				dw_data.setitem(i,"saldo",subgrup_saldo[j])
				dw_data.setitem(i,"saldo_anterior",subgrup_saldo_anterior[j])
				exit
			end if
		next
	end if
next

// 2ª oportunidad para calculo de los grupos con formula y que no 
// pudieron calcularse en la pasada anterior. Se hace ahora
for i = 1 to dw_data.rowcount()
	f_mensaje_proceso("Calculando saldo de grupos ",i,dw_data.rowcount())
	tipo = dw_data.getitemnumber(i,"tipo")
	
	// grupo con formula
	if tipo = 2 then		
		
		formula = trim(dw_data.getitemstring(i,"formula"))
		grupo = trim(dw_data.getitemstring(i,"grupo")			)
			
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				posicion = j
				exit
			end if 
		next
		
		if calculado_grupo[posicion] = "N" then				
			saldo = f_saldo_formula(formula,subgrup_nombre,subgrup_saldo,grupo_nombre,grupo_saldo,subgrup_saldo_anterior,grupo_saldo_anterior,posicion,saldo_anterior,calculado_grupo[])						
			dw_data.setitem(i,"saldo",saldo)
			dw_data.setitem(i,"saldo_grupo",saldo)
			dw_data.setitem(i,"saldo_grupo_ant",saldo_anterior)
			dw_data.setitem(i,"saldo_anterior",saldo_anterior)
		end if	
	end if
next


// 3ª oportunidad para calculo de los grupos con formula y que no 
// pudieron calcularse en la pasada anterior. Se hace ahora
for i = 1 to dw_data.rowcount()
	f_mensaje_proceso("Calculando saldo de grupos ",i,dw_data.rowcount())
	tipo = dw_data.getitemnumber(i,"tipo")
	
	// grupo con formula
	if tipo = 2 then		
		
		formula = trim(dw_data.getitemstring(i,"formula"))
		grupo = trim(dw_data.getitemstring(i,"grupo")			)
			
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				posicion = j
				exit
			end if 
		next
		
		if calculado_grupo[posicion] = "N" then				
			saldo = f_saldo_formula(formula,subgrup_nombre,subgrup_saldo,grupo_nombre,grupo_saldo,subgrup_saldo_anterior,grupo_saldo_anterior,posicion,saldo_anterior,calculado_grupo[])						
			dw_data.setitem(i,"saldo",saldo)
			dw_data.setitem(i,"saldo_grupo",saldo)
			dw_data.setitem(i,"saldo_grupo_ant",saldo_anterior)
			dw_data.setitem(i,"saldo_anterior",saldo_anterior)
		end if	
	end if
next

dw_data.groupcalc()
destroy d1
destroy d2












//
////String cuenta
//string cuenta2,formula,bloque,bloque2
//dec saldo,defecto,saldo_anterior
////int k
//
//
//
//for i=1 to registros 
//	cuenta=dw_data.getitemstring(i,"contaballin_cuenta")
//	// saldo por defecto de la cuenta
//	defecto=dw_data.getitemnumber(i,"contaballin_importe")
//	
//	if isnull(defecto) or defecto=0 then
//		// Cálculo del saldo de la cuenta si no tiene saldo defecto
//		saldo=f_saldo_cuenta_balance(anyo,codigo_empresa,cuenta,fdesde,fhasta)		
//		saldo_anterior = f_saldo_cuenta_balance(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)		
//		bloque = dw_data.getitemstring(i,"contabalgrup_bloque")
//		
//		// Comprobamos si la cuenta está dos veces en el balance
//		// No puede estar dos veces en el mismo bloque
//		// Puede estar en dos bloques diferentes pero sólo ha de aparecer en uno 
//		for k = i +1 to registros
//			cuenta2 = dw_data.getitemstring(k,"contaballin_cuenta")
//			if cuenta2 = cuenta then
//				bloque2 = dw_data.getitemstring(k,"contabalgrup_bloque")
//				if bloque = bloque2 then
//					messagebox("Error","La cuenta " + cuenta2 +" está repetida en el bloque "+ bloque2)
//				else
//					if bloque = "D" and saldo < 0 then
//						saldo = 0
//					else
//						if bloque = "H" and saldo > 0 then
//							saldo = 0
//						end if
//					end if
//				end if
//			end if
//		next
//		// Si es del haber el saldo es negativo. Se pasa a positivo
//		if bloque = "H" then 
//			saldo = saldo * (-1)
//			saldo_anterior = saldo_anterior * (-1)
//		end if
//	else
//		// Saldo por defecto en el la tabla de lineas
//		saldo = defecto
//	end if
//	
//	dw_data.setitem(i,"saldo",saldo)
//	dw_data.setitem(i,"saldo_anterior",saldo_anterior)
//	
//next
//
//dw_data.sort()
//dw_data.groupcalc()
//
//
//
// 
//
//string grupod,grupoh
//
//// Cálculo del saldo de los grupos que tienen fórmula
////long cd,ch,cc,n
//cd=dw_cursord.retrieve(codigo_empresa,uo_balance.em_codigo.text,'D')
//ch=dw_cursorh.retrieve(codigo_empresa,uo_balance.em_codigo.text,'H')
//cc=max(cd,ch)
////string grupod,grupoh
//for i=1 to cc
//	if i<=cd then
//		grupod=dw_cursord.getitemstring(i,"grupo")
//		dw_data.setfilter("contabalgrup_grupo='"+grupod+"'")
//		dw_data.filter()
//		for j=1 to dw_data.rowcount()
//			formula=dw_data.getitemstring(j,"contabalgrup_formula")
//			if formula<>"" and not isnull(formula) then
//				if j=1 then 
//					saldo=f_saldo_formula(dw_data,formula,j,saldo_anterior)
//					dw_data.setfilter("contabalgrup_grupo='"+grupod+"'")
//					dw_data.filter()
//				end if
//				if saldo<=0 then	saldo=0
//				if saldo_anterior <=0 then	saldo_anterior = 0			
//				
//				dw_data.setitem(j,"csal_for",saldo)
//				dw_data.setitem(j,"csal_for_anterior",saldo_anterior)
//			end if
//		next
//	end if
//	if i<=ch then
//		grupoh=dw_cursorh.getitemstring(i,"grupo")
//		dw_data.setfilter("contabalgrup_grupo='"+grupoh+"'")
//		dw_data.filter()
//		for j=1 to dw_data.rowcount()
//			formula=dw_data.getitemstring(j,"contabalgrup_formula")
//			if formula<>"" and not isnull(formula) then
//				if j=1 then
//					saldo=f_saldo_formula(dw_data,formula,j,saldo_anterior)
//					dw_data.setfilter("contabalgrup_grupo='"+grupoh+"'")
//					dw_data.filter()
//				end if
//				if saldo<=0 then saldo=0
//				if saldo_anterior<=0 then saldo_anterior=0
//				dw_data.setitem(j,"csal_for",saldo)
//				dw_data.setitem(j,"csal_for_anterior",saldo_anterior)
//			end if
//		next
//	end if	
//next
//
//
//// Mostramos los que tienen saldo
//dw_data.setfilter("saldo<>0 or (csal_for<>0 and contabalsubgrup_subgrupo='') or (csal_for<>0 and IsNull(contabalsubgrup_subgrupo))")
//dw_data.filter()
//
//dw_data.sort()
//dw_data.groupcalc()
//
//dw_data.setredraw(true)
//Setpointer(Arrow!)
//
//
end subroutine

public subroutine f_filtro (datawindow dw_data);string filtro

dw_data.setfilter("")
dw_data.filter()

// Con cuentas y valor cero
if cbx_1.checked and cbx_2.checked 				then filtro = ""    
// sin cuentas
if cbx_1.checked and not cbx_2.checked 		then filtro = " tipo <> "+"4 "
// sin valor cero
if not cbx_1.checked and cbx_2.checked 		then filtro = " saldo <> " + "0 "  + " or " +"( saldo = " + "0 " + "and  tipo = "+"1)" + " or " +"( saldo = " + "0 " + "and  tipo = "+"2)" 
// sin saldo y sin cuentas
if not cbx_1.checked and not cbx_2.checked 	then filtro = " saldo <> " + "0 and  tipo <> "+"4"  + " or " +"( saldo = " + "0 " + "and  tipo = "+"1)" + " or " +"( saldo = " + "0 " + "and  tipo = "+"2)" 
	



//if cbx_1.checked and cbx_2.checked 				then filtro = ""    
//if cbx_1.checked and not cbx_2.checked 		then filtro = " tipo <> "+"4"    
//if not cbx_1.checked and cbx_2.checked 		then filtro = " saldo <> " + "0 "
//if not cbx_1.checked and not cbx_2.checked 	then filtro = " saldo <> " + "0 and  tipo <> "+"4"        






dw_data.setfilter(filtro)
dw_data.filter()
dw_data.sort()
dw_data.groupcalc()

end subroutine

public function decimal f_saldo_formula (string formu, string subgrup_nombre[], decimal subgrup_saldo[], string grupo_nombre[], ref decimal grupo_saldo[], decimal subgrup_saldo_ant[], ref decimal grupo_saldo_ant[], long posicion, ref decimal retorno_anterior, ref string calculado_grupo[]);if formu="" or isnull(formu) then return 0
dec retorno,saldo_grupo,saldo_grupo_anterior
retorno=0
retorno_anterior = 0
long j,largo,principio,final,final1,final2
integer signo,signo_pos
signo=1
boolean continuo,falta_calculo
string grupo
long k

grupo=""
continuo=true
largo=len(formu)
principio=1
final=0

falta_calculo = false


DO while continuo
	saldo_grupo=0
	saldo_grupo_anterior = 0
	final1=Pos(formu,"+",principio)
	final2=Pos(formu,"-",principio)
	if final1=0 and final2=0 then
		final=largo+1
		continuo=False
	else
		if final1=0 then final1=largo
		if final2=0 then final2=largo		
		if final1 < final2 then
			final=final1
			signo_pos=1
			continuo=true
		else
			final=final2
			signo_pos=-1
			continuo=true
		end if
	end if
	cb_consulta.enabled=true
	grupo=mid(formu,principio,final - principio)
	string tipo
	tipo=left(grupo,1)
	grupo=right(grupo,len(grupo) - 1)
	// es un grupo	
	if tipo='G' then
		for k = 1 to upperbound(grupo_nombre)
			if grupo_nombre[k] = grupo then
				if calculado_grupo[k] = "S" then 				
					saldo_grupo = grupo_saldo[k]
					saldo_grupo_anterior = grupo_saldo_ant[k]
					exit
				else
					//messagebox("No se puede calcular grupo " + grupo_nombre[posicion],"falta el grupo " +grupo)
					
					falta_calculo = true
				end if
			end if
		next
	// es un subgrupo	
	else
		for k = 1 to upperbound(subgrup_nombre)
			if subgrup_nombre[k] = grupo then
				saldo_grupo = subgrup_saldo[k]
				saldo_grupo_anterior = subgrup_saldo_ant[k]
				exit
			end if
		next
		
		
	end if


	retorno= retorno + (signo * saldo_grupo)	
	retorno_anterior = retorno_anterior + (signo * saldo_grupo_anterior)	



	principio=final+1
	signo=signo_pos
LOOP


if retorno < 0 then retorno = 0
if retorno_anterior < 0 then retorno_anterior = 0
grupo_saldo[posicion] = retorno
grupo_saldo_ant[posicion] = retorno_anterior


if not falta_calculo then
	calculado_grupo[posicion] = "S"	
else
	calculado_grupo[posicion] = "N"
end if


return retorno
	
end function

public function boolean f_existe_cuenta (string arg_empresa, string arg_balance, string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_cuenta);int cuantos
boolean existe

existe = false




// Comprobamos que la cuenta no existe en otro boque
select count(*) into :cuantos
from contaballin
where contaballin.empresa 	= 	:arg_empresa
and	contaballin.codbal	=	:arg_balance	
and	contaballin.bloque	<>	:arg_bloque
and	contaballin.grupo		<>	:arg_grupo
and	contaballin.subgrupo	<> :arg_subgrupo
and   contaballin.cuenta	= 	:arg_cuenta;


if cuantos > 0 then
	existe = true
else
	existe = false
end if

return existe
end function

event open;call super::open;This.title = "BALANCES COMPARATIVOS"

dw_listado.settransobject(sqlca)


em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_cursord.settransobject(sqlca)
dw_cursorh.settransobject(sqlca)
f_activar_campo(em_fechadesde)

str_paramemp em
int dec_moneda
em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)

f_mascara_columna(dw_1,"saldo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo_formula",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo_grupo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo_subgrupo",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_1,"saldo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo_formula_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo_grupo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_1,"saldo_subgrupo_anterior",f_mascara_decimales(dec_moneda))



f_mascara_columna(dw_listado,"saldo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_formula",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_subgrupo",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_listado,"saldo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_formula_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_subgrupo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo_ant",f_mascara_decimales(dec_moneda))





cbx_1.checked = false
cbx_2.checked = false




end event

on w_balance_nuevo.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_22=create gb_22
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.gb_2=create gb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.dw_cursord=create dw_cursord
this.dw_cursorh=create dw_cursorh
this.dw_listado=create dw_listado
this.uo_balance=create uo_balance
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_22
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.em_fechahasta
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.pb_imprimir_preli
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.dw_cursord
this.Control[iCurrent+12]=this.dw_cursorh
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.uo_balance
this.Control[iCurrent+15]=this.cbx_1
this.Control[iCurrent+16]=this.cbx_2
this.Control[iCurrent+17]=this.cbx_3
end on

on w_balance_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_22)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.dw_cursord)
destroy(this.dw_cursorh)
destroy(this.dw_listado)
destroy(this.uo_balance)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_balance_nuevo
integer x = 800
integer y = 816
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_balance_nuevo
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_balance_nuevo
integer y = 20
integer width = 1893
end type

type pb_2 from upb_salir within w_balance_nuevo
integer x = 2729
integer y = 12
integer width = 110
integer height = 96
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_balance_nuevo
integer x = 32
integer y = 196
integer width = 297
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;call super::losefocus;anyo=year(date(em_fechadesde.text))
if anyo<year(today()) then em_fechahasta.text=string(date(anyo,12,31))
end event

type gb_22 from groupbox within w_balance_nuevo
integer x = 731
integer y = 116
integer width = 1234
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Balance"
end type

type gb_1 from groupbox within w_balance_nuevo
integer y = 116
integer width = 727
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_balance_nuevo
integer x = 1984
integer y = 188
integer width = 288
integer height = 80
integer taborder = 50
boolean bringtotop = true
string facename = "Arial"
string text = "Consulta"
end type

event clicked;IF not isdate(em_fechadesde.text) then
	messagebox("ERROR DE DATOS","Fecha desde NO válida",exclamation!)
	em_fechadesde.setfocus()
	return	
end if


IF not isdate(em_fechahasta.text) then
	messagebox("ERROR DE DATOS","Fecha hasta NO válida",exclamation!)
	em_fechahasta.setfocus()
	return	
end if

if date(em_fechahasta.text) < date(em_fechadesde.text) then
	messagebox("ERROR DE DATOS","Fecha hasta > que fecha desde",exclamation!)
	em_fechahasta.setfocus()
	return	
end if


if uo_balance.em_codigo.text = "" then
	messagebox("ERROR DE DATOS","Introduzca el balance",exclamation!)
	uo_balance.em_campo.setfocus()
	return	
end if
	
	
	
	


dw_1.reset()


dw_1.setfilter("")
dw_1.filter()


f_cargar(dw_1)
f_filtro(dw_1)

if dw_1.rowcount() > 0 then
	dw_1.visible = true
else
	messagebox("Atención","No hay cuentas")
	dw_1.reset()
	dw_1.visible = false
end if
end event

type em_fechahasta from u_em_campo within w_balance_nuevo
integer x = 407
integer y = 196
integer width = 293
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;integer anyo2
date fechah
fechah=date(em_fechahasta.text)
anyo2=year(fechah)

if anyo2<>anyo then 
	messagebox("Año Incorrecto","El año debe ser el mismo")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

if fechah<date(em_fechadesde.text) then 
	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
	em_fechahasta.text=string(date(anyo,12,31))
	f_activar_campo(em_fechahasta)
	RETURN
end if 

end event

type st_1 from statictext within w_balance_nuevo
integer x = 338
integer y = 176
integer width = 64
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_balance_nuevo
integer x = 1970
integer y = 120
integer width = 315
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_imprimir_preli from picturebutton within w_balance_nuevo
integer x = 2729
integer y = 172
integer width = 110
integer height = 96
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;long i,linea


IF not isdate(em_fechadesde.text) then
	messagebox("ERROR DE DATOS","Fecha desde NO válida",exclamation!)
	em_fechadesde.setfocus()
	return	
end if


IF not isdate(em_fechahasta.text) then
	messagebox("ERROR DE DATOS","Fecha hasta NO válida",exclamation!)
	em_fechahasta.setfocus()
	return	
end if

if date(em_fechahasta.text) < date(em_fechadesde.text) then
	messagebox("ERROR DE DATOS","Fecha hasta > que fecha desde",exclamation!)
	em_fechahasta.setfocus()
	return	
end if


if uo_balance.em_codigo.text = "" then
	messagebox("ERROR DE DATOS","Introduzca el balance",exclamation!)
	uo_balance.em_campo.setfocus()
	return	
end if
	


if not cbx_3.checked then 
	dw_listado.dataobject = "report_balance_compar_nuevo2"
else
	dw_listado.dataobject = "report_balance_compar_nuevo"
end if
dw_listado.settransobject(sqlca)



dw_listado.reset()


int dec_moneda
str_paramemp em

em = f_paramemp(codigo_empresa)
dec_moneda = f_decimales_moneda(em.moneda_emp)
f_mascara_columna(dw_listado,"saldo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_formula",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_subgrupo",f_mascara_decimales(dec_moneda))

f_mascara_columna(dw_listado,"saldo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_formula_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_subgrupo_anterior",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo",f_mascara_decimales(dec_moneda))
f_mascara_columna(dw_listado,"saldo_grupo_ant",f_mascara_decimales(dec_moneda))






// Ya se ha hecho la consulta en pantalla. 
if dw_1.rowcount() > 0 then
	dw_listado.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),uo_balance.em_codigo.text)
	for i = 1 to dw_1.rowcount()
		linea = dw_listado.insertrow(0)		
		dw_listado.setitem(linea,"cuenta",trim(dw_1.getitemstring(i,"cuenta")))
		dw_listado.setitem(linea,"nombre_cuenta",trim(dw_1.getitemstring(i,"nombre_cuenta")))
		dw_listado.setitem(linea,"grupo",trim(dw_1.getitemstring(i,"grupo")))
		dw_listado.setitem(linea,"subgrupo",trim(dw_1.getitemstring(i,"subgrupo")))
		dw_listado.setitem(linea,"nombre_grupo",trim(dw_1.getitemstring(i,"nombre_grupo")))
		dw_listado.setitem(linea,"nombre_subgrupo",trim(dw_1.getitemstring(i,"nombre_subgrupo")))
		dw_listado.setitem(linea,"formula",trim(dw_1.getitemstring(i,"formula")))		
		dw_listado.setitem(linea,"bloque",trim(dw_1.getitemstring(i,"bloque")))
		
		dw_listado.setitem(linea,"saldo",dw_1.getitemnumber(i,"saldo"))
		dw_listado.setitem(linea,"saldo_anterior",dw_1.getitemnumber(i,"saldo_anterior"))
		dw_listado.setitem(linea,"tipo",dw_1.getitemnumber(i,"tipo"))
		dw_listado.setitem(linea,"orden",dw_1.getitemnumber(i,"orden"))
		dw_listado.setitem(linea,"saldo_grupo",dw_1.getitemnumber(i,"saldo_grupo"))
		dw_listado.setitem(linea,"saldo_grupo_ant",dw_1.getitemnumber(i,"saldo_grupo_ant"))
		dw_listado.setitem(linea,"visible",dw_1.getitemnumber(i,"visible"))

		f_mensaje_proceso("Calculando Balance ",i,dw_1.rowcount())
	next
	
	dw_listado.groupcalc()
	
else
	f_cargar(dw_listado)
	f_filtro(dw_listado)
end if
if dw_listado.rowcount() > 0 then
	
else
	messagebox("Atención","No hay cuentas")
	dw_listado.reset()
	dw_listado.visible = false
end if



f_imprimir_datawindow(dw_listado)

end event

type dw_1 from datawindow within w_balance_nuevo
boolean visible = false
integer x = 18
integer y = 320
integer width = 3488
integer height = 1744
boolean bringtotop = true
string dataobject = "dw_balance_nuevo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_cursord from datawindow within w_balance_nuevo
boolean visible = false
integer x = 905
integer y = 120
integer width = 677
integer height = 244
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_cursor_contabal"
boolean livescroll = true
end type

type dw_cursorh from datawindow within w_balance_nuevo
boolean visible = false
integer x = 1595
integer y = 140
integer width = 329
integer height = 200
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_cursor_contabal"
boolean livescroll = true
end type

type dw_listado from datawindow within w_balance_nuevo
boolean visible = false
integer x = 2574
integer y = 12
integer width = 69
integer height = 52
string dataobject = "report_balance_compar_nuevo"
boolean livescroll = true
end type

type uo_balance from u_em_campo_2 within w_balance_nuevo
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 763
integer y = 196
integer width = 1170
integer height = 80
integer taborder = 40
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabal(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabal"
ue_filtro     = ""

end event

on uo_balance.destroy
call u_em_campo_2::destroy
end on

type cbx_1 from checkbox within w_balance_nuevo
integer x = 2295
integer y = 120
integer width = 352
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Valor cero"
end type

event clicked;f_filtro(dw_1)

end event

type cbx_2 from checkbox within w_balance_nuevo
integer x = 2295
integer y = 184
integer width = 393
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Con cuentas"
end type

event clicked;f_filtro(dw_1)
end event

type cbx_3 from checkbox within w_balance_nuevo
integer x = 2295
integer y = 244
integer width = 329
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Listar %"
end type

