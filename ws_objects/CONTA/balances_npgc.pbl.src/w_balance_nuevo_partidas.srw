$PBExportHeader$w_balance_nuevo_partidas.srw
forward
global type w_balance_nuevo_partidas from w_int_con_empresa
end type
type pb_2 from upb_salir within w_balance_nuevo_partidas
end type
type cb_consulta from u_boton within w_balance_nuevo_partidas
end type
type pb_imprimir_preli from picturebutton within w_balance_nuevo_partidas
end type
type dw_1 from datawindow within w_balance_nuevo_partidas
end type
type dw_cursord from datawindow within w_balance_nuevo_partidas
end type
type dw_cursorh from datawindow within w_balance_nuevo_partidas
end type
type dw_listado from datawindow within w_balance_nuevo_partidas
end type
type cbx_cero from checkbox within w_balance_nuevo_partidas
end type
type cbx_ctas from checkbox within w_balance_nuevo_partidas
end type
type dw_saldo_partidas from datawindow within w_balance_nuevo_partidas
end type
type cbx_ejer from checkbox within w_balance_nuevo_partidas
end type
type st_1 from statictext within w_balance_nuevo_partidas
end type
type em_fechadesde from u_em_campo within w_balance_nuevo_partidas
end type
type em_fechahasta from u_em_campo within w_balance_nuevo_partidas
end type
type uo_balance from u_em_campo_2 within w_balance_nuevo_partidas
end type
type cbx_convertir_npgc from checkbox within w_balance_nuevo_partidas
end type
type gb_1 from groupbox within w_balance_nuevo_partidas
end type
type gb_22 from groupbox within w_balance_nuevo_partidas
end type
type gb_3 from groupbox within w_balance_nuevo_partidas
end type
type gb_2 from groupbox within w_balance_nuevo_partidas
end type
type gb_4 from groupbox within w_balance_nuevo_partidas
end type
end forward

global type w_balance_nuevo_partidas from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3717
integer height = 2156
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_1 dw_1
dw_cursord dw_cursord
dw_cursorh dw_cursorh
dw_listado dw_listado
cbx_cero cbx_cero
cbx_ctas cbx_ctas
dw_saldo_partidas dw_saldo_partidas
cbx_ejer cbx_ejer
st_1 st_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
uo_balance uo_balance
cbx_convertir_npgc cbx_convertir_npgc
gb_1 gb_1
gb_22 gb_22
gb_3 gb_3
gb_2 gb_2
gb_4 gb_4
end type
global w_balance_nuevo_partidas w_balance_nuevo_partidas

type variables
integer anyo

end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_filtro (datawindow dw_data)
public function boolean f_existe_cuenta (string arg_empresa, string arg_balance, string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_cuenta)
public subroutine f_acumular_partida (string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_partida, decimal arg_saldo, decimal arg_saldo_ant)
public function decimal f_saldo_partida (string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_partida)
public function decimal f_saldo_partida_anterior (string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_partida)
public function decimal f_saldo_formula (string formu, string subgrup_nombre[], decimal subgrup_saldo[], string grupo_nombre[], ref decimal grupo_saldo[], decimal subgrup_saldo_ant[], ref decimal grupo_saldo_ant[], long posicion, ref decimal retorno_anterior, ref string calculado_grupo[])
end prototypes

public subroutine f_cargar (datawindow dw_data);long 		registros,i,j,k,m,linea,indice_subgrupo,indice_grupo
long 		cd,ch,cc,n,orden,max,posicion
int 		ejer,tipo,l,conejer,factord,factorh
string 	bloque,grupo,subgrupo,cuenta,formula,partida
string 	fd_ant,fh_ant,es_visible
string 	sel1,sel2,sel3
string 	calculado_grupo[],grupo_nombre[],subgrup_nombre[]
datetime fdesde,fhasta,fdesde_anterior,fhasta_anterior
dec 		defecto,saldo,saldo_anterior 
dec 		grupo_saldo[],subgrup_saldo[]
dec 		grupo_saldo_anterior[],subgrup_saldo_anterior[]
dec 		saldo_6,saldo_7,saldo_ant_6,saldo_ant_7
dec 		saldo_129,saldo_ant_129
boolean 	existe_cuenta
datastore d1,d2,d3

ejer = f_ejercicio_activo(codigo_empresa)
anyo = year(date(em_fechadesde.text))

dw_data.SetTransObject(sqlca)
dw_data.reset()
Setpointer(HourGlass!)

dw_data.setredraw(false)
dw_saldo_partidas.setredraw(false)
dw_saldo_partidas.retrieve()

fdesde = datetime(date(em_fechadesde.text))
fhasta = datetime(date(em_fechahasta.text))

IF fdesde > fhasta THEN
	Messagebox("ATENCION","La fecha DESDE es mayor que HASTA")
	RETURN
END IF

fd_ant = string(day(date(fdesde))) +"/" + string(month(date(fdesde))) + "/" + string(year(date(fdesde)) - 1)
fh_ant = string(day(date(fhasta))) +"/" + string(month(date(fhasta))) + "/" + string(year(date(fhasta)) - 1)

fdesde_anterior = datetime(date(fd_ant))
fhasta_anterior = datetime(date(fh_ant))

IF cbx_ejer.Checked THEN
	conejer = 0
ELSE
	conejer = 1
END IF

// Leemos el factor de multiplicacion de los bloques de debe y haber del balance
SELECT factor_debe,factor_haber INTO :factord,:factorh FROM contabalnpgc
WHERE contabalnpgc.empresa	= :codigo_empresa
AND	contabalnpgc.balance	= :uo_balance.em_codigo.text;

IF IsNull(factord) OR factord = 0 THEN factord = 1
IF IsNull(factorh) OR factorh = 0 THEN factorh = -1

dw_data.retrieve(codigo_empresa,fdesde,fhasta,uo_balance.em_codigo.text,conejer)

cd = dw_cursord.retrieve(codigo_empresa,uo_balance.em_codigo.text,'D')
ch = dw_cursorh.retrieve(codigo_empresa,uo_balance.em_codigo.text,'H')

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
	
	for i = 1 to max
		f_mensaje_proceso("Calculando saldo bloque " + bloque,i,max)
		
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
		
		indice_grupo ++
		grupo_nombre[indice_grupo] 			= grupo
		grupo_saldo[indice_grupo] 				= 0
		grupo_saldo_anterior[indice_grupo] 	= 0
		
		IF Mid(titulo,1,1) <> '.' THEN
			linea = dw_data.insertrow(0)
					
			dw_data.setitem(linea,"grupo",grupo)
			dw_data.setitem(linea,"nombre_cuenta",titulo)
			dw_data.setitem(linea,"tipo",1)
			dw_data.setitem(linea,"bloque",bloque)
			orden = orden + 1 
			dw_data.setitem(linea,"orden",orden)
			dw_data.setitem(linea,"visible",1)
		END IF
			
		if formula <> "" then
			// Si el grupo tiene formula no debe verse el saldo del grupo
			// sino el de la formula
			dw_data.setitem(linea,"visible",0)
			
			linea = dw_data.insertrow(0)
				
			dw_data.setitem(linea,"grupo",grupo)
			dw_data.setitem(linea,"nombre_cuenta",formula)
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
		
		// Seleccionamos los subgrupos
		sel1 = 	" Select * from contabalsubgrupnpgc " + &
					" where empresa 	= 	'" + codigo_empresa + "'" + &
					" and codbal 		=	'" + uo_balance.em_codigo.text + "'" +&
					" and bloque		=	'" + bloque + "'" + &
					" and grupo		=	'"	+	grupo + "'" + &
					" order by orden"
		
		d1 = f_cargar_cursor(sel1)
		
		for j = 1 to d1.rowcount()
			subgrupo =  trim(d1.getitemstring(j,"subgrupo"))
			
			indice_subgrupo ++
			subgrup_nombre[indice_subgrupo] 				= subgrupo
			subgrup_saldo[indice_subgrupo] 				= 0
			subgrup_saldo_anterior[indice_subgrupo] 	= 0
			
			titulo	=	trim(d1.getitemstring(j,"titulo"))
			es_visible  = 	trim(d1.getitemstring(j,"visible"))
			if isnull(es_visible) then es_visible = "S"
			if es_visible = "S" then
				linea = dw_data.insertrow(0)
				
				dw_data.setitem(linea,"grupo",grupo)
				dw_data.setitem(linea,"subgrupo",subgrupo)
				dw_data.setitem(linea,"nombre_cuenta",titulo)
				dw_data.setitem(linea,"tipo",3)
				dw_data.setitem(linea,"bloque",bloque)
				dw_data.setitem(linea,"visible",1)
			
				orden = orden + 1 
				dw_data.setitem(linea,"orden",orden)
			end if
			
			// Seleccionamos las partidas de un subgrupo
			sel3 =   " Select partida,titulo,visible " + &
					" from contabalpartidanpgc " + &
					" where empresa 	= 	'" + codigo_empresa + "'" + &
					" and codbal 		=	'" + uo_balance.em_codigo.text + "'" +&
					" and bloque			=	'" + bloque + "'" + &
					" and grupo			=	'"	+	grupo + "'" + &
					" and subgrupo		=	'"	+	subgrupo + "'" + &
					" order by orden"
			
			d3 = f_cargar_cursor(sel3)
			for m = 1 to d3.rowcount()
				partida 		= trim(d3.getitemstring(m,"partida"))
				titulo		= trim(d3.getitemstring(m,"titulo"))
				es_visible	= trim(d3.getitemstring(m,"visible"))				
				if isnull(es_visible) then es_visible = "S"
				// Sólo se inserta si se ha declarado como visible
				if es_visible = "S" then
					linea = dw_data.insertrow(0)
					dw_data.setitem(linea,"grupo",grupo)
					dw_data.setitem(linea,"subgrupo",subgrupo)
					dw_data.setitem(linea,"nombre_cuenta",titulo)
					dw_data.setitem(linea,"partida",partida )
					dw_data.setitem(linea,"tipo",5)
					dw_data.setitem(linea,"bloque",bloque)
					dw_data.setitem(linea,"visible",1)
					orden = orden + 1 
					dw_data.setitem(linea,"orden",orden)
				end if
				sel2 = " Select * from contaballinnpgc " + &
						" where empresa 	= 	'" + codigo_empresa + "'" + &
						" and codbal 		=	'" + uo_balance.em_codigo.text + "'" +&
						" and bloque			=	'" + bloque + "'" + &
						" and grupo			=	'"	+	grupo + "'" + &
						" and subgrupo		=	'"	+	subgrupo + "'" + &
						" and partida     =  '" + partida + "'" + &
						" order by orden"
				
				d2 = f_cargar_cursor(sel2)
				
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
						
						choose case cuenta
//							 Si la cuenta es la 120 (Remanente) se le pone el saldo
//							 de la cuenta 129
							case "120"
								if not(cbx_convertir_npgc.checked) then
									saldo 		= f_saldo_cuenta_balance_npgc(anyo,codigo_empresa,cuenta,fdesde,fhasta)		
									saldo_129  	= f_saldo_cuenta_balance_npgc(anyo,codigo_empresa,"129",fdesde,fhasta)
								else
									saldo 		= f_saldo_cuenta_convertida_balance_npgc(anyo,codigo_empresa,cuenta,fdesde,fhasta)		
									saldo_129  	= f_saldo_cuenta_convertida_balance_npgc(anyo,codigo_empresa,"129",fdesde,fhasta)								
								end if
								saldo 		= saldo + saldo_129
								
								IF conejer = 1 THEN
									if not(cbx_convertir_npgc.checked) then
										saldo_anterior = f_saldo_cuenta_balance_npgc(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)		
										saldo_ant_129 	= f_saldo_cuenta_balance_npgc(anyo - 1,codigo_empresa,"129",fdesde_anterior,fhasta_anterior)
									else
										saldo_anterior = f_saldo_cuenta_convertida_balance_npgc(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)		
										saldo_ant_129 	= f_saldo_cuenta_convertida_balance_npgc(anyo - 1,codigo_empresa,"129",fdesde_anterior,fhasta_anterior)										
									end if
									saldo_anterior = saldo_anterior + saldo_ant_129
								ELSE
									saldo_anterior = 0
								END IF
							
							// Si la cuenta es la 129 ponemos la 6 - la 7
							// El saldo de la 129 se pone en la 120
							case "129" 
								saldo = 0
								saldo_anterior = 0
								if not(cbx_convertir_npgc.checked) then								
									saldo_6 = f_saldo_cuenta_balance_npgc(anyo,codigo_empresa,"6",fdesde,fhasta)
									saldo_7 = f_saldo_cuenta_balance_npgc(anyo,codigo_empresa,"7",fdesde,fhasta)
								else
									saldo_6 = f_saldo_cuenta_convertida_balance_npgc(anyo,codigo_empresa,"6",fdesde,fhasta)
									saldo_7 = f_saldo_cuenta_convertida_balance_npgc(anyo,codigo_empresa,"7",fdesde,fhasta)									
								end if
				
								saldo = saldo + saldo_6 + saldo_7
								// Si la 129 en el ejercicio ant no tiene saldo
								IF conejer = 1 THEN
									if not(cbx_convertir_npgc.checked) then	
										saldo_ant_6 = f_saldo_cuenta_balance_npgc(anyo - 1,codigo_empresa,"6",fdesde_anterior,fhasta_anterior)
										saldo_ant_7 = f_saldo_cuenta_balance_npgc(anyo - 1,codigo_empresa,"7",fdesde_anterior,fhasta_anterior)
									else
										saldo_ant_6 = f_saldo_cuenta_convertida_balance_npgc(anyo - 1,codigo_empresa,"6",fdesde_anterior,fhasta_anterior)
										saldo_ant_7 = f_saldo_cuenta_convertida_balance_npgc(anyo - 1,codigo_empresa,"7",fdesde_anterior,fhasta_anterior)										
									end if
									saldo_anterior = saldo_anterior + saldo_ant_6 + saldo_ant_7
								END IF
																		
							case else
								if not(cbx_convertir_npgc.checked) then
									saldo	= f_saldo_cuenta_balance_npgc(anyo,codigo_empresa,cuenta,fdesde,fhasta)
								else
									saldo	= f_saldo_cuenta_convertida_balance_npgc(anyo,codigo_empresa,cuenta,fdesde,fhasta)
								end if
								IF conejer = 1 THEN
									if not(cbx_convertir_npgc.checked) then
										saldo_anterior = f_saldo_cuenta_balance_npgc(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)
									else
										saldo_anterior = f_saldo_cuenta_convertida_balance_npgc(anyo - 1,codigo_empresa,cuenta,fdesde_anterior,fhasta_anterior)
									end if
								ELSE
									saldo_anterior = 0
								END IF
							end choose
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
													
					// Multiplicamos el saldo por el factor de multiplicacion ( 1 o -1 ) del bloque del balance
					IF bloque = 'D' THEN
						saldo 			= saldo * factord	
						saldo_anterior = saldo_anterior * factord
					ELSE
						saldo 			= saldo * factorh	
						saldo_anterior = saldo_anterior * factorh
					END IF
				
					// acumulamos en el grupo y subgrupo
					grupo_saldo[indice_grupo] 				= grupo_saldo[indice_grupo] + saldo							
					grupo_saldo_anterior[indice_grupo] 	= grupo_saldo_anterior[indice_grupo] + saldo_anterior 											
					subgrup_saldo[indice_subgrupo] 		= subgrup_saldo[indice_subgrupo] + saldo			
					subgrup_saldo_anterior[indice_subgrupo] = subgrup_saldo_anterior[indice_subgrupo] + saldo_anterior			
					// acumulamos en la partida
					f_acumular_partida(bloque,grupo,subgrupo,partida,saldo,saldo_anterior)
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
					dw_data.setitem(linea,"partida",partida)
					dw_data.setitem(linea,"visible",1)
					orden = orden + 1 
					dw_data.setitem(linea,"orden",orden)
				next
				Destroy(d2)
			next	
			Destroy(d3)
		next
		Destroy(d1)
	next
next

// Se añade el saldo de subgrupo y grupos
for i = 1 to dw_data.rowcount()
	f_mensaje_proceso("Calculando saldo de grupos ",i,dw_data.rowcount())
	tipo = dw_data.getitemnumber(i,"tipo")
	// Es un grupo sin formula. El valor para el grupo es la suma de las cuentas
	if tipo = 1 then		
		grupo = trim(dw_data.getitemstring(i,"grupo"))
		bloque = dw_data.Object.bloque[i]
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
		formula = trim(dw_data.getitemstring(i,"formula"))
		grupo = trim(dw_data.getitemstring(i,"grupo")			)
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				posicion = j
				exit
			end if 
		next
		
		saldo = f_saldo_formula(formula,subgrup_nombre,subgrup_saldo,grupo_nombre,grupo_saldo,subgrup_saldo_anterior,&
				grupo_saldo_anterior,posicion,saldo_anterior,calculado_grupo[])						
		dw_data.setitem(i,"saldo",saldo)
		dw_data.setitem(i,"saldo_grupo",saldo)
		dw_data.setitem(i,"saldo_grupo_ant",saldo_anterior)
		dw_data.setitem(i,"saldo_anterior",saldo_anterior)
	end if
	
	
	// Es un subgrupo. Su saldo siempre es la suma de las cuentas que lo componen
	if	tipo = 3 then 
		subgrupo = trim(dw_data.getitemstring(i,"subgrupo"))
		bloque	= dw_data.Object.bloque[i]
		for j = 1 to upperbound(subgrup_nombre) 
			if subgrup_nombre[j] = subgrupo then
				dw_data.setitem(i,"saldo",subgrup_saldo[j])
				dw_data.setitem(i,"saldo_anterior",subgrup_saldo_anterior[j])
				exit
			end if
		next
	end if
	if tipo = 5 then
		// Es una partida . Su saldo está acumulado en una dw
		bloque 	= trim(dw_data.getitemstring(i,"bloque"))
		grupo 	= trim(dw_data.getitemstring(i,"grupo"))
		subgrupo = trim(dw_data.getitemstring(i,"subgrupo"))
		partida	= trim(dw_data.getitemstring(i,"partida"))
		
		dw_data.setitem(i,"saldo",f_saldo_partida(bloque,grupo,subgrupo,partida))
		dw_data.setitem(i,"saldo_anterior",f_saldo_partida_anterior(bloque,grupo,subgrupo,partida))	
	end if	
next

// 2ª oportunidad para calculo de los grupos con formula y que no 
// pudieron calcularse en la pasada anterior. Se hace ahora
for i = 1 to dw_data.rowcount()
	f_mensaje_proceso("Calculando saldo de grupos ",i,dw_data.rowcount())
	tipo = dw_data.getitemnumber(i,"tipo")
	
	// grupo con formula
	if tipo = 2 then		
		formula 	= trim(dw_data.getitemstring(i,"formula"))
		grupo 	= trim(dw_data.getitemstring(i,"grupo"))
		bloque	= dw_data.Object.bloque[i]
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				posicion = j
				exit
			end if 
		next
		if calculado_grupo[posicion] = "N" then				
			saldo = f_saldo_formula(formula,subgrup_nombre,subgrup_saldo,grupo_nombre,grupo_saldo,subgrup_saldo_anterior,&
				grupo_saldo_anterior,posicion,saldo_anterior,calculado_grupo[])
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
		grupo = trim(dw_data.getitemstring(i,"grupo"))
		bloque	= dw_data.Object.bloque[i]	
		for j = 1 to upperbound(grupo_nombre)
			if grupo = grupo_nombre[j] then
				posicion = j
				exit
			end if 
		next
		
		if calculado_grupo[posicion] = "N" then				
			saldo = f_saldo_formula(formula,subgrup_nombre,subgrup_saldo,grupo_nombre,grupo_saldo,subgrup_saldo_anterior,&
				grupo_saldo_anterior,posicion,saldo_anterior,calculado_grupo[])
			dw_data.setitem(i,"saldo",saldo)
			dw_data.setitem(i,"saldo_grupo",saldo)
			dw_data.setitem(i,"saldo_grupo_ant",saldo_anterior)
			dw_data.setitem(i,"saldo_anterior",saldo_anterior)
		end if	
	end if
next

dw_data.Sort()
dw_data.groupcalc()















end subroutine

public subroutine f_filtro (datawindow dw_data);string filtro

dw_data.setfilter("")
dw_data.filter()

// Con cuentas y valor cero
if cbx_cero.checked and cbx_ctas.checked 				then filtro = ""    
// sin cuentas
if cbx_cero.checked and not cbx_ctas.checked 		then filtro = " tipo <> "+"4 "
// sin valor cero
if not cbx_cero.checked and cbx_ctas.checked 		then filtro = " saldo <> " + "0 "  + " or " +"( saldo = " + "0 " + "and  tipo = "+"1)" + " or " +"( saldo = " + "0 " + "and  tipo = "+"2)" 
// sin saldo y sin cuentas
if not cbx_cero.checked and not cbx_ctas.checked 	then filtro = " saldo <> " + "0 and  tipo <> "+"4"  + " or " +"( saldo = " + "0 " + "and  tipo = "+"1)" + " or " +"( saldo = " + "0 " + "and  tipo = "+"2)" 
	
dw_data.setfilter(filtro)
dw_data.filter()
dw_data.sort()
dw_data.groupcalc()

end subroutine

public function boolean f_existe_cuenta (string arg_empresa, string arg_balance, string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_cuenta);int cuantos
boolean existe

existe = false




// Comprobamos que la cuenta no existe en otro boque
select count(*) into :cuantos
from contaballinnpgc
where empresa 	= 	:arg_empresa
and	codbal	=	:arg_balance	
and	bloque	<>	:arg_bloque
and	grupo		<>	:arg_grupo
and	subgrupo	<> :arg_subgrupo
and   cuenta	= 	:arg_cuenta;


if cuantos > 0 then
	existe = true
else
	existe = false
end if

return existe
end function

public subroutine f_acumular_partida (string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_partida, decimal arg_saldo, decimal arg_saldo_ant);long e,linea 
string filtro
dec saldo,saldo_ant

filtro = "bloque = '"+arg_bloque+"' and grupo = '" + arg_grupo + "' and subgrupo = '" + arg_subgrupo + "' and partida = '" + arg_partida + "'"

e = dw_saldo_partidas.find(filtro,1,dw_saldo_partidas.rowcount())

if e = 0 then
	linea = dw_saldo_partidas.insertrow(0)
	dw_saldo_partidas.setitem(linea,"bloque",arg_bloque)
	dw_saldo_partidas.setitem(linea,"grupo",arg_grupo)
	dw_saldo_partidas.setitem(linea,"subgrupo",arg_subgrupo)
	dw_saldo_partidas.setitem(linea,"partida",arg_partida)
	dw_saldo_partidas.setitem(linea,"saldo",arg_saldo)
	dw_saldo_partidas.setitem(linea,"saldo_ant",arg_saldo_ant)
	
else
	saldo = dw_saldo_partidas.getitemnumber(e,"saldo") 
	saldo_ant = dw_saldo_partidas.getitemnumber(e,"saldo_ant") 
	
	saldo = saldo + arg_saldo
	saldo_ant = saldo_ant + arg_saldo_ant
	
	dw_saldo_partidas.setitem(e,"saldo",saldo) 
	dw_saldo_partidas.setitem(e,"saldo_ant",saldo_ant) 
	
end if





end subroutine

public function decimal f_saldo_partida (string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_partida);long e,linea 
string filtro
dec saldo,saldo_ant

filtro = "bloque = '"+arg_bloque+"' and grupo = '" + arg_grupo + "' and subgrupo = '" + arg_subgrupo + "' and partida = '" + arg_partida + "'"

e = dw_saldo_partidas.find(filtro,1,dw_saldo_partidas.rowcount())

if e = 0 then
	saldo = 0
	
else
	saldo = dw_saldo_partidas.getitemnumber(e,"saldo") 
		
end if





return saldo


end function

public function decimal f_saldo_partida_anterior (string arg_bloque, string arg_grupo, string arg_subgrupo, string arg_partida);long e,linea 
string filtro
dec saldo,saldo_ant

filtro = "bloque = '"+arg_bloque+"' and grupo = '" + arg_grupo + "' and subgrupo = '" + arg_subgrupo + "' and partida = '" + arg_partida + "'"

e = dw_saldo_partidas.find(filtro,1,dw_saldo_partidas.rowcount())

if e = 0 then
	saldo_ant = 0
	
else
	saldo_ant = dw_saldo_partidas.getitemnumber(e,"saldo_ant") 
		
end if





return saldo_ant


end function

public function decimal f_saldo_formula (string formu, string subgrup_nombre[], decimal subgrup_saldo[], string grupo_nombre[], ref decimal grupo_saldo[], decimal subgrup_saldo_ant[], ref decimal grupo_saldo_ant[], long posicion, ref decimal retorno_anterior, ref string calculado_grupo[]);if formu="" or isnull(formu) then return 0

dec 		retorno = 0,saldo_grupo,saldo_grupo_anterior
long 		j,largo,principio,final,final1,final2,k
integer 	signo = 1,signo_pos
boolean 	continuo,falta_calculo
string	grupo,tipo

retorno_anterior 	= 0
grupo					= ""
continuo				= true
largo					= len(formu)
principio			= 1
final					= 0
falta_calculo 		= false

//IF LEFT(FORMU,3) = "G12" THEN
//	MESSAGEBOX("",FORMU)
//END IF
//
DO while continuo
	saldo_grupo				= 0
	saldo_grupo_anterior = 0
	final1	= Pos(formu,"+",principio)
	final2	= Pos(formu,"-",principio)
	if final1 = 0 and final2 = 0 then
		final 	= largo + 1
		continuo = False
	else
		if final1 = 0 then final1 = largo
		if final2 = 0 then final2 = largo		
		if final1 < final2 then
			final = final1
			signo_pos = 1
			continuo  = true
		else
			final		= final2
			signo_pos= -1
			continuo	= true
		end if
	end if
	cb_consulta.enabled = true
	grupo = mid(formu,principio,final - principio)
	
	tipo	= left(grupo,1)
	grupo	= right(grupo,len(grupo) - 1)
	// es un grupo	
	if tipo = 'G' then
		for k = 1 to upperbound(grupo_nombre)
			if grupo_nombre[k] = grupo then
				if calculado_grupo[k] = "S" then 				
					saldo_grupo = grupo_saldo[k]
					saldo_grupo_anterior = grupo_saldo_ant[k]
					exit
				else
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
	retorno				= retorno + (signo * saldo_grupo)	
	retorno_anterior 	= retorno_anterior + (signo * saldo_grupo_anterior)	
	principio			= final+1
	signo					= signo_pos
LOOP

//Quitar en caso de error
//IF Dec(uo_balance.em_codigo.text) < 21 THEN
//	if retorno < 0 then retorno = 0
//	if retorno_anterior < 0 then retorno_anterior = 0
//END IF

grupo_saldo[posicion] = retorno
grupo_saldo_ant[posicion] = retorno_anterior


if not falta_calculo then
	calculado_grupo[posicion] = "S"	
else
	calculado_grupo[posicion] = "N"
end if

return retorno
	
end function

event open;call super::open;This.title = "BALANCES NPGC"

dw_listado.settransobject(sqlca)
dw_saldo_partidas.settransobject(sqlca)
dw_cursord.settransobject(sqlca)
dw_cursorh.settransobject(sqlca)

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
f_activar_campo(em_fechadesde)
end event

on w_balance_nuevo_partidas.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_1=create dw_1
this.dw_cursord=create dw_cursord
this.dw_cursorh=create dw_cursorh
this.dw_listado=create dw_listado
this.cbx_cero=create cbx_cero
this.cbx_ctas=create cbx_ctas
this.dw_saldo_partidas=create dw_saldo_partidas
this.cbx_ejer=create cbx_ejer
this.st_1=create st_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.uo_balance=create uo_balance
this.cbx_convertir_npgc=create cbx_convertir_npgc
this.gb_1=create gb_1
this.gb_22=create gb_22
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_cursord
this.Control[iCurrent+6]=this.dw_cursorh
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.cbx_cero
this.Control[iCurrent+9]=this.cbx_ctas
this.Control[iCurrent+10]=this.dw_saldo_partidas
this.Control[iCurrent+11]=this.cbx_ejer
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.em_fechadesde
this.Control[iCurrent+14]=this.em_fechahasta
this.Control[iCurrent+15]=this.uo_balance
this.Control[iCurrent+16]=this.cbx_convertir_npgc
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_22
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_4
end on

on w_balance_nuevo_partidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_1)
destroy(this.dw_cursord)
destroy(this.dw_cursorh)
destroy(this.dw_listado)
destroy(this.cbx_cero)
destroy(this.cbx_ctas)
destroy(this.dw_saldo_partidas)
destroy(this.cbx_ejer)
destroy(this.st_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.uo_balance)
destroy(this.cbx_convertir_npgc)
destroy(this.gb_1)
destroy(this.gb_22)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_4)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_balance_nuevo_partidas
integer x = 800
integer y = 816
integer taborder = 0
borderstyle borderstyle = stylelowered!
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_balance_nuevo_partidas
integer x = 55
integer height = 40
end type

type st_empresa from w_int_con_empresa`st_empresa within w_balance_nuevo_partidas
integer width = 2642
integer height = 104
end type

type pb_2 from upb_salir within w_balance_nuevo_partidas
integer x = 3483
integer y = 4
integer width = 142
integer height = 116
integer taborder = 0
string picturename = "exit!"
end type

type cb_consulta from u_boton within w_balance_nuevo_partidas
integer x = 2821
integer y = 156
integer width = 517
integer height = 108
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
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

dw_1.groupcalc()
end event

type pb_imprimir_preli from picturebutton within w_balance_nuevo_partidas
integer x = 3488
integer y = 156
integer width = 128
integer height = 108
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "Print!"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = uo_balance.em_campo.text
u_imp.isSubTitulo = "Fecha Apunte desde '"+em_fechadesde.text +"' Hasta '"+em_fechahasta.text+"'"
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)
u_imp.event ue_imprimir(dw_1)

//long 	i,linea
//int 	conejer
//
//IF not isdate(em_fechadesde.text) then
//	messagebox("ERROR DE DATOS","Fecha desde NO válida",exclamation!)
//	em_fechadesde.setfocus()
//	return	
//end if
//
//
//IF not isdate(em_fechahasta.text) then
//	messagebox("ERROR DE DATOS","Fecha hasta NO válida",exclamation!)
//	em_fechahasta.setfocus()
//	return	
//end if
//
//if date(em_fechahasta.text) < date(em_fechadesde.text) then
//	messagebox("ERROR DE DATOS","Fecha hasta > que fecha desde",exclamation!)
//	em_fechahasta.setfocus()
//	return	
//end if
//
//
//if uo_balance.em_codigo.text = "" then
//	messagebox("ERROR DE DATOS","Introduzca el balance",exclamation!)
//	uo_balance.em_campo.setfocus()
//	return	
//end if
//
//dw_listado.reset()
//
//IF cbx_ejer.Checked THEN
//	conejer = 0
//ELSE
//	conejer = 1
//END IF
//
//// Ya se ha hecho la consulta en pantalla. 
//if dw_1.rowcount() > 0 then
//	dw_listado.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),uo_balance.em_codigo.text,conejer)
//	for i = 1 to dw_1.rowcount()
//		linea = dw_listado.insertrow(0)		
//		dw_listado.setitem(linea,"cuenta",trim(dw_1.getitemstring(i,"cuenta")))
//		dw_listado.setitem(linea,"nombre_cuenta",trim(dw_1.getitemstring(i,"nombre_cuenta")))
//		dw_listado.setitem(linea,"grupo",trim(dw_1.getitemstring(i,"grupo")))
//		dw_listado.setitem(linea,"subgrupo",trim(dw_1.getitemstring(i,"subgrupo")))
//		dw_listado.setitem(linea,"nombre_grupo",trim(dw_1.getitemstring(i,"nombre_grupo")))
//		dw_listado.setitem(linea,"nombre_subgrupo",trim(dw_1.getitemstring(i,"nombre_subgrupo")))
//		dw_listado.setitem(linea,"formula",trim(dw_1.getitemstring(i,"formula")))		
//		dw_listado.setitem(linea,"bloque",trim(dw_1.getitemstring(i,"bloque")))
//		
//		dw_listado.setitem(linea,"saldo",dw_1.getitemnumber(i,"saldo"))
//		dw_listado.setitem(linea,"saldo_anterior",dw_1.getitemnumber(i,"saldo_anterior"))
//		dw_listado.setitem(linea,"tipo",dw_1.getitemnumber(i,"tipo"))
//		dw_listado.setitem(linea,"orden",dw_1.getitemnumber(i,"orden"))
//		dw_listado.setitem(linea,"saldo_grupo",dw_1.getitemnumber(i,"saldo_grupo"))
//		dw_listado.setitem(linea,"saldo_grupo_ant",dw_1.getitemnumber(i,"saldo_grupo_ant"))
//		dw_listado.setitem(linea,"visible",dw_1.getitemnumber(i,"visible"))
//		dw_listado.setitem(linea,"partida",dw_1.getitemstring(i,"partida"))
//		dw_listado.setitem(linea,"nombre_partida",dw_1.getitemstring(i,"nombre_partida"))
//		
//		f_mensaje_proceso("Calculando Balance ",i,dw_1.rowcount())
//	next
//	
//	dw_listado.groupcalc()
//	
//else
//	f_cargar(dw_listado)
//	f_filtro(dw_listado)
//end if
//if dw_listado.rowcount() > 0 then
//	f_imprimir_datawindow(dw_listado)
//else
//	messagebox("Atención","No hay cuentas")
//	dw_listado.reset()
//	dw_listado.visible = false
//end if
//
end event

type dw_1 from datawindow within w_balance_nuevo_partidas
boolean visible = false
integer y = 296
integer width = 3630
integer height = 1640
boolean bringtotop = true
string dataobject = "dw_balance_nuevo_partida"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_cursord from datawindow within w_balance_nuevo_partidas
boolean visible = false
integer x = 3022
integer y = 24
integer width = 155
integer height = 60
boolean bringtotop = true
string dataobject = "dw_cursor_contabalnpgc"
boolean livescroll = true
end type

type dw_cursorh from datawindow within w_balance_nuevo_partidas
boolean visible = false
integer x = 3195
integer y = 20
integer width = 201
integer height = 76
boolean bringtotop = true
string dataobject = "dw_cursor_contabalnpgc"
boolean livescroll = true
end type

type dw_listado from datawindow within w_balance_nuevo_partidas
boolean visible = false
integer x = 2693
integer y = 24
integer width = 114
integer height = 96
string dataobject = "report_balance_nuevo"
boolean livescroll = true
end type

type cbx_cero from checkbox within w_balance_nuevo_partidas
integer x = 2391
integer y = 212
integer width = 338
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Valor cero"
boolean checked = true
end type

event clicked;f_filtro(dw_1)

end event

type cbx_ctas from checkbox within w_balance_nuevo_partidas
integer x = 2391
integer y = 160
integer width = 398
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Con cuentas"
end type

event clicked;f_filtro(dw_1)
end event

type dw_saldo_partidas from datawindow within w_balance_nuevo_partidas
boolean visible = false
integer x = 2816
integer y = 12
integer width = 183
integer height = 96
boolean bringtotop = true
string dataobject = "dw_saldo_partidasnpgc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_ejer from checkbox within w_balance_nuevo_partidas
integer x = 1769
integer y = 212
integer width = 361
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "1 Ejercicio"
end type

event clicked;f_filtro(dw_1)

end event

type st_1 from statictext within w_balance_nuevo_partidas
integer x = 338
integer y = 168
integer width = 64
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "_"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_balance_nuevo_partidas
integer x = 32
integer y = 172
integer width = 297
integer taborder = 30
boolean bringtotop = true
integer weight = 400
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;call super::losefocus;anyo=year(date(em_fechadesde.text))
//if anyo<year(today()) then em_fechahasta.text=string(date(anyo,12,31))
end event

type em_fechahasta from u_em_campo within w_balance_nuevo_partidas
integer x = 407
integer y = 172
integer width = 293
integer taborder = 40
boolean bringtotop = true
integer weight = 400
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

type uo_balance from u_em_campo_2 within w_balance_nuevo_partidas
event destroy ( )
integer x = 745
integer y = 172
integer width = 987
integer taborder = 50
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_balance.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_balance.em_campo.text=f_nombre_contabalnpgc(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_contabalnpgc"
ue_filtro     = ""

end event

type cbx_convertir_npgc from checkbox within w_balance_nuevo_partidas
integer x = 1769
integer y = 160
integer width = 581
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Convirtiendo NPGC"
end type

type gb_1 from groupbox within w_balance_nuevo_partidas
integer y = 116
integer width = 727
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha Apunte"
end type

type gb_22 from groupbox within w_balance_nuevo_partidas
integer x = 731
integer y = 116
integer width = 1019
integer height = 160
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Balance"
end type

type gb_3 from groupbox within w_balance_nuevo_partidas
integer x = 1751
integer y = 116
integer width = 1056
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Opciones"
end type

type gb_2 from groupbox within w_balance_nuevo_partidas
integer x = 2807
integer y = 116
integer width = 544
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_4 from groupbox within w_balance_nuevo_partidas
integer x = 3351
integer y = 116
integer width = 279
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

