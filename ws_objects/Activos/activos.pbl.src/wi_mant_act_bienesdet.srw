$PBExportHeader$wi_mant_act_bienesdet.srw
forward
global type wi_mant_act_bienesdet from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_act_bienesdet
end type
type cb_amort from u_boton within wi_mant_act_bienesdet
end type
type uo_ejercicio from u_ejercicio within wi_mant_act_bienesdet
end type
type dw_2 from datawindow within wi_mant_act_bienesdet
end type
end forward

global type wi_mant_act_bienesdet from wi_mvent_con_empresa
integer width = 2871
integer height = 1688
pb_calculadora pb_calculadora
cb_amort cb_amort
uo_ejercicio uo_ejercicio
dw_2 dw_2
end type
global wi_mant_act_bienesdet wi_mant_act_bienesdet

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
Boolean	requiere_anyo
end variables

forward prototypes
public subroutine f_borrar_espacios ()
public subroutine f_calcula_fin_amort ()
public subroutine f_sacadehasta (string tipo_amor, datetime lafe, ref decimal dias, ref decimal elpe, ref datetime f2)
public subroutine f_saca_anyos_degr ()
end prototypes

public subroutine f_borrar_espacios ();// Eliminamos los espacios
int linea
 
linea = dw_1.getrow()  
IF LINEA > 0 THEN
	dw_1.setitem(linea,"descripcion",trim(dw_1.getitemstring(linea,"descripcion")))
	dw_1.setitem(linea,"familia",trim(dw_1.getitemstring(linea,"familia")))
	dw_1.setitem(linea,"ctaproveedor",trim(dw_1.getitemstring(linea,"ctaproveedor")))
	dw_1.setitem(linea,"cuenta_activo",trim(dw_1.getitemstring(linea,"cuenta_activo")))
	dw_1.setitem(linea,"cuenta_cargo",trim(dw_1.getitemstring(linea,"cuenta_cargo")))
	dw_1.setitem(linea,"cuenta_abono",trim(dw_1.getitemstring(linea,"cuenta_abono")))
	dw_1.setitem(linea,"tipo_amor",trim(dw_1.getitemstring(linea,"tipo_amor")))
	dw_1.setitem(linea,"clase_amor",trim(dw_1.getitemstring(linea,"clase_amor")))
	dw_1.setitem(linea,"observaciones",trim(dw_1.getitemstring(linea,"observaciones")))
	dw_1.setitem(linea,"seccion",trim(dw_1.getitemstring(linea,"seccion")))
	dw_1.setitem(linea,"centro_coste",trim(dw_1.getitemstring(linea,"centro_coste")))
	dw_1.setitem(linea,"tipo_bien",trim(dw_1.getitemstring(linea,"tipo_bien")))
	dw_1.setitem(linea,"factura",trim(dw_1.getitemstring(linea,"factura")))
	dw_1.setitem(linea,"referencia_tipo",trim(dw_1.getitemstring(linea,"referencia_tipo")))
end if

end subroutine

public subroutine f_calcula_fin_amort ();Dec valor,n1,n2,n3,n4
Integer	fila
String	c1

fila = dw_1.GetRow()

c1 = dw_1.GetItemString(fila,"clase_amor")		
If c1 = 'R' then
	f_saca_anyos_degr()
	Return
End If

valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")		
If valor <>0 then
	n1 = 100 / valor
	n2 = n1 * valor
	If n2<100 then n1 = n1 + 1
	n3 = dw_1.GetItemDecimal(fila,"anyo1amor")				
	dw_1.SetItem(fila,"anyo2amor",n3 + n1)
End If	

valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")		
valor = valor / 12
If valor <> 0 then
	n1 = 100 / valor
	n2 = n1 * valor
	If n2<100 then n1 = n1 + 1
	n2 = dw_1.GetItemDecimal(fila,"anyo1amor")
	n3 = dw_1.GetItemDecimal(fila,"mes1amor")
	n4 = dw_1.GetItemDecimal(fila,"anyo2amor")
	valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
	If valor < 1 then
		valor = valor + 12
		n4 = n4 - 1 
		dw_1.SetItem(fila,"anyo2amor",n4)
	ElseIf valor > 12 then
		valor = valor - 12
		n4 = n4 + 1 
		dw_1.SetItem(fila,"anyo2amor",n4)
	End If
	dw_1.SetItem(fila,"mes2amor",valor)			
Else
	dw_1.SetItem(fila,"mes2amor",0)			
End If
end subroutine

public subroutine f_sacadehasta (string tipo_amor, datetime lafe, ref decimal dias, ref decimal elpe, ref datetime f2);decimal	elej 
datetime		f1

f1 = lafe
elej = year(date(lafe))
f2 = datetime(mdy(12,31,elej))


CHOOSE CASE tipo_amor
   CASE "A"
		elpe = 1
	   f2 = datetime(mdy(12,31,year(date(lafe))))
   CASE "S" 
		IF month(date(lafe)) < 7 THEN
	     f2 = datetime(mdy(06,30,year(date(lafe))))
	     elpe = 1
	   ELSE
	     elpe = 2
      END IF
   CASE "T" 
		IF month(date(lafe)) < 13 THEN
	     elpe       = 4
      END IF
      IF month(date(lafe)) < 10 THEN
			f2 = datetime(mdy(09,30,year(date(lafe))))
		   elpe = 3
      END IF
      IF month(date(lafe)) < 7 THEN
	   	f2 = datetime(mdy(06,30,year(date(lafe))))
			elpe       = 2
      END IF
      IF month(date(lafe)) < 4 THEN
	   	f2 = datetime(mdy(03,31,year(date(lafe))))
			elpe       = 1
		END IF
   CASE "M"
		elpe = month(date(lafe))
	   IF elpe  <> 12 THEN
	   	f2 = datetime(RelativeDate(mdy((elpe+1),01,year(date(lafe))), -1))
		END IF
END CHOOSE


dias = DaysAfter(date(f1),date(f2)) + 1
end subroutine

public subroutine f_saca_anyos_degr ();Amortizaciones	a
Datetime		fechain
Integer	diasanyo,fila,num_meses
Dec		amortizado,xbajabase,xbajaamor,xbajaresto,diasperiodo,base,pte 
Dec		importe,restoprevisto,n12,n1,valor,cuota_amor
Dec		importe_amor_lin,elemento,veces,anyos,anyoin,mesin,coef_degr
String	c1,c3,c4,c6,c11,ultima

dw_1.AcceptText()

veces = 0

elemento = dec(sle_valor.text)
fila = dw_1.GetRow()
	
a.clase_inmobilizado = dw_1.GetItemDecimal(fila,"clase_inmobilizado")
a.tipo_amor= dw_1.GetItemString(fila,"tipo_amor")
a.porcentaje_amor = dw_1.GetItemDecimal(fila,"porcentaje_amor")
a.fecha_amor = dw_1.GetItemDateTime(fila,"fechainamor")
//le damos unos valores por defecto porque este campo no es necesario conocerlo realmente
If isnull(a.fecha_amor) then a.fecha_amor = DateTime(Date("01-01-1999"))
restoprevisto = dw_1.GetItemDecimal(fila,"restoprevisto")
If isnull(restoprevisto) then restoprevisto = 0
importe = dw_1.GetItemDecimal(fila,"importe")
//le damos unos valores por defecto porque este campo no es necesario conocerlo realmente
If isnull(importe) then importe = 10000
//inicial = dw_1.GetItemDecimal(fila,"amor_acumulada")
//IF isnull(inicial) THEN inicial = 0 
coef_degr = dw_1.GetItemDecimal(fila,"coef_degr")

ultima = "N"

fechain = a.fecha_amor
 
a.ejercicio = year(date(fechain))

f_sacadehasta(a.tipo_amor,fechain,diasperiodo,a.periodo,a.fecha_amor)
// cambia el valor de diasperiodo,a.periodo,a.fecha_amor

// amortizado = inicial
amortizado = 0


   SELECT sum(ibajabase),sum(ibajaamor),sum(ibajaresto)
     INTO :xbajabase,:xbajaamor,:xbajaresto
     FROM act_bajas
    WHERE act_bajas.empresa = :codigo_empresa
      AND act_bajas.elemento =:elemento
      AND act_bajas.fechaba < :fechain;
		
 IF isnull(xbajabase) then xbajabase = 0 
 IF isnull(xbajaamor) then xbajaamor = 0 
 IF isnull(xbajaresto) then xbajaresto = 0 
 amortizado = amortizado - xbajaamor
 base = importe - xbajabase - (restoprevisto -xbajaresto)

 diasanyo=DaysAfter(mdy(1,1,a.ejercicio),mdy(12,31,a.ejercicio)) + 1

//f_mensaje("debug","1" + char(13) + string(amortizado) + ' ' + string(base))


DO WHILE amortizado < base
   veces = veces + 1	
//	f_mensaje("debug","veces = " + string(veces)+ char(13) + string(amortizado) + ' <= ' + string(base))
	pte = base - amortizado
	a.importe_amor = (pte) * a.porcentaje_amor / 100
	a.importe_amor = (a.importe_amor * diasperiodo) / diasanyo	  
	IF amortizado + a.importe_amor > base THEN
		a.importe_amor = base - amortizado
	END IF
	// si la amortización degresiva es menor que la cálculada con el coeficiente
	 // mínimo, entonces hay que amortizar todo lo pendiente
		 
	importe_amor_lin 	= ((base * coef_degr) / 100)
	 // --cuota del periodo
	 importe_amor_lin	= (importe_amor_lin * diasperiodo) / diasanyo
	 IF amortizado + importe_amor_lin > base THEN
		importe_amor_lin 	= base - amortizado
	 END IF

	If a.importe_amor < importe_amor_lin then a.importe_amor = base - amortizado


 amortizado = amortizado + a.importe_amor 
 fechain = datetime(RelativeDate(date(a.fecha_amor), 1))
 a.ejercicio = year(date(fechain))
 diasanyo = DaysAfter( mdy(01,01,a.ejercicio) , mdy(12,31,a.ejercicio) ) + 1 
 f_sacadehasta(a.tipo_amor,fechain,diasperiodo,a.periodo,a.fecha_amor)
// f_mensaje("","diasperiodo = " + string(diasperiodo) + ' periodo = ' + string(a.periodo) + ' fecha_amor = ' + string(a.fecha_amor,"dd-mm-yy"))
//f_mensaje("debug","2")  
LOOP
//f_mensaje("debug","3")
//f_mensaje("debug",string(anyos))

//f_mensaje("debug","veces = " + string(veces))

choose case a.tipo_amor 
	case 'A'
		anyos = veces
	case 'S'
		anyos = veces / 2 
		num_meses = (mod(veces,2) )* 6
	case 'T'
		anyos = veces / 4
		num_meses = (mod(veces,4) ) * 3
	case 'M'
		anyos = veces / 12
		num_meses = mod(veces,12)  
end choose

//f_mensaje("",string(veces) + char(13) + string(anyos) + char(13) + string(num_meses))

If anyos<>0 then 
	dw_1.SetItem(dw_1.GetRow(),"anyos_amor",anyos)

	anyoin = dw_1.GetItemDecimal(dw_1.GetRow(),"anyo1amor")
	mesin = dw_1.GetItemDecimal(dw_1.GetRow(),"mes1amor")
	
	choose case a.tipo_amor 
		case 'S'
			If mesin>=6 then 
				mesin = 12
			Else
				mesin = 6
			End If
		case 'T'
			If mesin>9 then
				mesin = 12
			ElseIf mesin>6 then
					mesin = 9
				ElseIf mesin>3 then
						mesin = 6
					Else
						mesin = 3
			End If				
	end choose
	
	If not isnull(mesin) then 
		mesin = mesin + num_meses
 
 		choose case a.tipo_amor 
			case 'A' 
				dw_1.SetItem(dw_1.GetRow(),"mes2amor",12)
			case 'S'
				If Integer(mesin)>6 then
					dw_1.SetItem(dw_1.GetRow(),"mes2amor",12)
				Else
					dw_1.SetItem(dw_1.GetRow(),"mes2amor",6)
				End If
			case 'T'
				If Integer(mesin)>9 then
					dw_1.SetItem(dw_1.GetRow(),"mes2amor",12)
				ElseIf Integer(mesin)>6 then
						dw_1.SetItem(dw_1.GetRow(),"mes2amor",9)
					ElseIf Integer(mesin)>3 then
							dw_1.SetItem(dw_1.GetRow(),"mes2amor",6)
						Else
							dw_1.SetItem(dw_1.GetRow(),"mes2amor",3)
				End If				
			case 'M'
				dw_1.SetItem(dw_1.GetRow(),"mes2amor",Integer(mesin))
		End choose
	End If
		
	anyos = Round(anyos,0)
	If not isnull(anyoin) then dw_1.SetItem(dw_1.GetRow(),"anyo2amor",Integer(anyos + anyoin - 1))
End IF	
end subroutine

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Elementos de Amortización" 
	valor_empresa = True
	istr_parametros.s_listado        = "report_act_bienesdet"
   This.title = istr_parametros.s_titulo_ventana
   
	
	dw_2.SetTransObject(sqlca)
	
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,integer(sle_valor.Text))
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"elemento",integer(sle_valor.text))
   dw_1.setitem(dw_1.getrow(),"padre",integer(sle_valor.text)) //por defecto su padre es él mismo
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "act_bienesdet"

dw_1.Retrieve(codigo_empresa,integer(sle_valor.Text))
dw_2.Visible = False

CALL Super::ue_recuperar
end event

on wi_mant_act_bienesdet.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_amort=create cb_amort
this.uo_ejercicio=create uo_ejercicio
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_amort
this.Control[iCurrent+3]=this.uo_ejercicio
this.Control[iCurrent+4]=this.dw_2
end on

on wi_mant_act_bienesdet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_amort)
destroy(this.uo_ejercicio)
destroy(this.dw_2)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_act_bienesdet
integer x = 27
integer y = 240
integer width = 2821
integer height = 1196
string dataobject = "dwact_bienesdet"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;Dec	valor,n1,n2,n3,n4,n_ant
String cuenta,cadena,c1,c2,c3,c4,c5,c6,c7,c_ant
DateTime	fecha


choose case dwo.name

//	case 'bien'
//		cadena = trim(GetItemString(Row,"familia"))
//		If not (isnull(cadena) or trim(cadena)='') then
//			if f_desc_familia(codigo_empresa,cadena)='' then
//				f_mensaje("Aviso","No existe la familia.")
//				SetColumn("familia")			
//			else
//	 		  SELECT act_familias.cuenta_activo,   
//						act_familias.tipo_amor,   
//						act_familias.clase_amor
//				 INTO :c3,   
//						:c4,   
//						:c5
//				 FROM act_familias  
//				WHERE ( act_familias.empresa = :codigo_empresa ) AND  
//						( act_familias.familia = :cadena )   ;
//						
//				c3 = trim(c3)
//				c4 = trim(c4)
//				c5 = trim(c5)
//						
//				IF SQLCA.SQLCode = 0 THEN
//					c_ant = trim(GetItemString(row,"cuenta_activo"))
//					If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"cuenta_activo",c3)
//					c_ant = trim(GetItemString(row,"tipo_amor"))
//					If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"tipo_amor",c4)
//					c_ant = trim(GetItemString(row,"clase_amor"))
//					If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"clase_amor",c5)
//				End If
//			end if
//		End If
//		
//	case 'tipo_bien'
//		valor = GetItemDecimal(row,"bien")
//		If not (isnull(valor)) then
//			if f_desc_bien(codigo_empresa,valor)='' then
//				f_mensaje("Aviso","No existe el bien.")
//				SetColumn("bien")			
//			End If
//		End If
//		
	case 'anyo_tipo'		
		cadena = trim(GetItemString(row,"tipo_bien"))
		If not (isnull(cadena) or trim(cadena)='') then
			  SELECT act_tipobien.requiere_anyo, act_tipobien.tipo_bien  
				 INTO :c1,:c2  
				 FROM act_tipobien  
				WHERE ( act_tipobien.empresa = :codigo_empresa ) AND  
						( act_tipobien.tipo_bien = :cadena )   ;
						
				c1 = trim(c1)
				c2 = trim(c2)
						
				If SQLCA.SQLCode = 0 then
					If isnull(c1) or c1<>'S' then
						requiere_anyo = False
//						SetColumn("turnos")
						SetColumn("clase_amor")
					Else
						requiere_anyo = True
					End If 
				End If
		End If

	case 'referencia_tipo'
		cadena = trim(GetItemString(row,"tipo_bien"))
		If not (isnull(cadena) or trim(cadena)='') then
			  SELECT act_tipobien.requiere_anyo, act_tipobien.tipo_bien  
				 INTO :c1,:c2  
				 FROM act_tipobien  
				WHERE ( act_tipobien.empresa = :codigo_empresa ) AND  
						( act_tipobien.tipo_bien = :cadena )   ;
						
				c1 = trim(c1)
				c2 = trim(c2)
						
				If SQLCA.SQLCode = 0 then
					If isnull(c1) or c1<>'S' then
						requiere_anyo = False
//						SetColumn("turnos")
						SetColumn("clase_amor")
					Else
						requiere_anyo = True
					End If 
				End If
		End If

//		
//	case 'ctaproveedor'
//		valor = GetItemDecimal(row,"clase_inmobilizado")
//		If not isnull(valor) then
//			  SELECT act_clase.por_maxlineal,   
//						act_clase.por_minlineal,   
//						act_clase.cuenta_cargo,   
//						act_clase.cuenta_abono  
//				 INTO :n1,   
//						:n2,   
//						:c1,   
//						:c2  
//				 FROM act_clase  
//				WHERE ( act_clase.empresa = :codigo_empresa ) AND  
//						( act_clase.clase = :valor )   ;
//						
//				c1 = trim(c1)
//				c2 = trim(c2)
//						
//				If SQLCA.SQLCode = 0 then
//					n_ant = GetItemDecimal(row,"porcentaje_amor")
//					If isnull(n_ant) then SetItem(row,"porcentaje_amor",n1) // n1 <- porcentaje_amor
//					n_ant = GetItemDecimal(row,"anyos_amor")
//					If isnull(n_ant) then 
//						If n1<>0 then
//							SetItem(row,"anyos_amor",100/n1)
//						Else
//							SetItem(row,"anyos_amor",0)
//						End If
//					End If
//					n3 = GetItemDecimal(Row,"turnos")
//					If not isnull(n3) and n3<>1 then
//						n1 = n2 +((n1 - n2) * n3) // n1 <- porcentaje_amor
//						SetItem(row,"porcentaje_amor",n1 ) 
//					End If
//					c3 = trim(GetItemString(Row,"clase_amor"))
//					If not isnull(c3) then
//						If c3='R' then
//							n2 = GetItemDecimal(Row,"anyos_amor")
//							If not isnull(n2) then
//								If n2 < 5 then
//									n1 = n1 * 3/2
//								elseif n2 < 8 then
//										n1 = n1 * 2
//									 else
//										n1 = n1 * 5/2
//								end if	
//								SetItem(row,"porcentaje_amor",n1 ) 								 
//							End IF
//						End if
//					end IF					
//				Else
//					f_mensaje("Aviso","No existe la clase de inmobilizado.")
//					SetColumn("clase_inmobilizado")					
//				End If
//				n_ant = GetItemDecimal(row,"fiscal")
//				If isnull(n_ant) then SetItem(row,"fiscal",n1)
//				c_ant = trim(GetItemString(row,"cuenta_cargo"))
//				If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"cuenta_cargo",c1)
//				c_ant = trim(GetItemString(row,"cuenta_abono"))
//				If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"cuenta_abono",c2)	
//		End If
//		
//	case 'factura'
//		cuenta = trim(GetItemString(Row,"ctaproveedor"))
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta del proveedor.")
//				SetColumn("cuenta_activo")			
//			end if
//		End If
//		
//	case 'porcentaje_amor'
//		fecha = GetItemDateTime(Row,"fechainamor")		
//		If isnull(fecha) then 
//			fecha = GetItemDateTime(Row,"fechacompra")		
//			SetItem(Row,"fechainamor",fecha)
//		End If
//		SetItem(Row,"anyo1amor",Year(date(fecha)))
//		SetItem(Row,"mes1amor",Month(date(fecha)))
//		
//	case 'fiscal'
//		valor = GetItemDecimal(Row,"porcentaje_amor")		
//		// cálculo de anyo2amor
//		If valor <>0 then
//			n1 = 100 / valor
//			n2 = n1 * valor
//			If n2<100 then n1 = n1 + 1
//			n3 = GetItemDecimal(Row,"anyo1amor")				
//			SetItem(Row,"anyo2amor",n3 + n1)
//		End If	
//		// cálculo de mes2amor
//		valor = valor / 12
//		If valor <> 0 then
//			n1 = 100 / valor
//			n2 = n1 * valor
//			If n2<100 then n1 = n1 + 1
//			n2 = GetItemDecimal(Row,"anyo1amor")
//			n3 = GetItemDecimal(Row,"mes1amor")
//			n4 = GetItemDecimal(Row,"anyo2amor")
//			valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
//			If valor < 1 then
//				valor = valor + 12
//				n4 = n4 - 1 
//				SetItem(Row,"anyo2amor",n4)
//			End If
//			SetItem(Row,"mes2amor",valor)			
//		Else
//			SetItem(Row,"mes2amor",0)			
//		End If
//	
//		
//	case 'tipo_amor'
//		valor = GetItemDecimal(Row,"fiscal")		
//		If isnull(valor) then 
//			valor = GetItemDecimal(Row,"porcentaje_amor")		
//			SetItem(Row,"fiscal",valor)
//		End If		
//		
//	case 'anyo1amor'
//		valor = GetItemDecimal(Row,"porcentaje_amor")		
//		If isnull(valor) or valor = 0 then
//			SetItem(Row,"anyos_amor",0)
//		Else
//			SetItem(Row,"anyos_amor",100/valor)
//		end if
//
///*	case 'mes2amor'
//		valor = GetItemDecimal(Row,"porcentaje_amor")		
//		n1 = 100 / valor
//		n2 = n1 * valor
//		If n2<100 then n1 = n1 + 1
//		n3 = GetItemDecimal(Row,"anyo1amor")				
//		SetItem(Row,"anyo2amor",n3 + n1)
//		
//	case 'cuenta_activo'
//		valor = GetItemDecimal(Row,"porcentaje_amor")
//		valor = valor / 12
//		If valor <> 0 then
//			n1 = 100 / valor
//			n2 = n1 * valor
//			If n2<100 then n1 = n1 + 1
//			n2 = GetItemDecimal(Row,"anyo1amor")
//			n3 = GetItemDecimal(Row,"mes1amor")
//			n4 = GetItemDecimal(Row,"anyo2amor")
//			valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
//			If valor < 1 then
//				valor = valor + 12
//				n4 = n4 - 1 
//				SetItem(Row,"anyo2amor",n4)
//			End If
//			SetItem(Row,"mes2amor",valor)			
//		Else
//			SetItem(Row,"mes2amor",0)			
//		End If
//*/		
//	case 'cuenta_cargo'
//		cuenta = trim(GetItemString(Row,"cuenta_activo"))
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de activo.")
//				SetColumn("cuenta_activo")			
//			end if
//		End If
//		
//	case 'cuenta_abono'
//		cuenta = trim(GetItemString(Row,"cuenta_cargo"))
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de cargo.")
//				SetColumn("cuenta_cargo")			
//			end if
//		End If
//		
//	case 'cuota_amor'
//		cuenta = trim(GetItemString(Row,"cuenta_abono"))
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de abono.")
//				SetColumn("cuenta_abono")			
//			end if
//		End If
//		
//	case 'amor_acumulada'
//		valor = GetItemDecimal(Row,"cuota_amor")
//		n1 = GetItemDecimal(Row,"porcentaje_amor")
//		If ((isnull(valor)) or (valor = 0)) and n1<>0 then
//			cadena = trim(GetItemString(Row,"tipo_amor"))
//			n3 = GetItemDecimal(Row,"importe")
//			choose case cadena
//				case 'A'
//					valor = n3 * n1 /100
//				case 'S'
//					valor = (n3 * n1 /100)/2
//				case 'T'
//					valor = (n3 * n1 /100)/4
//				case 'M'
//					valor = (n3 * n1 /100)/12
//			end choose
//			SetItem(Row,"cuota_amor",valor)						
//		End If
//		
end choose		
end event

event dw_1::key;String cuenta

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "familia"
      bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
 		bus_datawindow = "dw_ayuda_act_familias"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "bien"
      bus_titulo     = "AYUDA SELECCION DE BIENES"
 		bus_datawindow = "dw_ayuda_act_bienes"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "tipo_bien"
      bus_titulo     = "AYUDA SELECCION DE TIPOS DE AMORTIZACION"
 		bus_datawindow = "dw_ayuda_act_tipobien"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'" 
	CASE "clase_inmobilizado"
      bus_titulo     = "AYUDA SELECCION DE CLASES DE INMOBILIZADO"
 		bus_datawindow = "dw_ayuda_act_clase"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "ctaproveedor","cuenta_activo","cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
 		bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
	CASE "centro_coste"
		If GetRow()<> 0 then
			cuenta = GeTItemString(GetRow(),"cuenta_cargo")
		Else
			cuenta = ''
		End If
      bus_titulo     = "AYUDA SELECCION DE CENTRO DE COSTES"
 		bus_datawindow = "dw_ayuda_costesplan_directo_cta"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text + " and cuenta ='" + cuenta + "'"
	CASE "ubicacion"
      bus_titulo     = "AYUDA SELECCION DE UBICACIONES"
 		bus_datawindow = "dw_ayuda_act_ubicacion"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::rbuttondown;String	cuenta
 
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "familia"
      bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
 		bus_datawindow = "dw_ayuda_act_familias"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "bien"
      bus_titulo     = "AYUDA SELECCION DE BIENES"
 		bus_datawindow = "dw_ayuda_act_bienes"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "tipo_bien"
      bus_titulo     = "AYUDA SELECCION DE TIPOS DE AMORTIZACION"
 		bus_datawindow = "dw_ayuda_act_tipobien"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "clase_inmobilizado"
      bus_titulo     = "AYUDA SELECCION DE CLASES DE INMOBILIZADO"
 		bus_datawindow = "dw_ayuda_act_clase"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"
	CASE "ctaproveedor","cuenta_activo","cuenta_cargo","cuenta_abono"
      bus_titulo     = "AYUDA SELECCION DEL PLAN DE CUENTAS"
		bus_datawindow = "dw_ayuda_contaplan_directo"
//		bus_datawindow = "dw_ayuda_contaplan_activo_directo"
//		bus_filtro      = "ejercicio = '" + uo_ejercicio.em_ejercicio.text + " and cuenta like '" + "40%" + "'"
//		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
	CASE "centro_coste"
		If GetRow()<> 0 then
			cuenta = GeTItemString(GetRow(),"cuenta_cargo")
		Else
			cuenta = ''
		End If
      bus_titulo     = "AYUDA SELECCION DE CENTRO DE COSTES"
 		bus_datawindow = "dw_ayuda_costesplan_directo_cta"
		bus_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text + " and cuenta ='" + cuenta + "'"
	CASE "ubicacion"
      bus_titulo     = "AYUDA SELECCION DE UBICACIONES"
 		bus_datawindow = "dw_ayuda_act_ubicacion"
//		bus_filtro      = "empresa = '" + codigo_empresa + "'"		
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

event dw_1::clicked;call super::clicked;//f_borrar_espacios()

If not isnull(dwo) then
	If dwo.name = "obs_actualizaciones" then
		dw_2.Retrieve(codigo_empresa,integer(sle_valor.Text))
		dw_2.visible = True
	End IF
End If
end event

event dw_1::itemchanged;Dec	valor,n1,n2,n3,n4,n_ant,años
String cuenta,cadena,c1,c2,c3,c4,c5,c6,c7,c_ant,sel
DateTime fecha
Integer resp
DataStore ds_costes


// FSF 01/09/99
// He quitado las comprobaciones de ver si un campo existe o no porque
// impedía que se ejectuase bien la ayuda
// Las comprobaciones se hacen ahora en el botón aceptar.

choose case dwo.name



	case 'familia'
		cadena = data
		If not (isnull(cadena) or trim(cadena)='') then
			if f_desc_familia(codigo_empresa,cadena)="" then
//				f_mensaje("Aviso","No existe la familia.")
//				SetColumn("familia")			
			else
	 		  SELECT act_familias.cuenta_activo,   
						act_familias.tipo_amor,   
						act_familias.clase_amor
				 INTO :c3,   
						:c4,   
						:c5
				 FROM act_familias  
				WHERE ( act_familias.empresa = :codigo_empresa ) AND  
						( act_familias.familia = :cadena )   ;
				
				if isnull(c3) then c3 = ""
				if isnull(c4) then c4 = ""
				if isnull(c5) then c5 = ""
				c3 = trim(c3)
				c4 = trim(c4)
				c5 = trim(c5)
						
				IF SQLCA.SQLCode = 0 THEN
					//f_mensaje("debug",c3+' '+c4+' '+c5 )
				//	c_ant = trim(GetItemString(row,"cuenta_activo"))
				//	If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"cuenta_activo",c3)
					c_ant = trim(GetItemString(row,"tipo_amor"))
					If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"tipo_amor",c4)
					c_ant = trim(GetItemString(row,"clase_amor"))
					If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"clase_amor",c5)
				End If
			end if
		End If
		

//	case 'bien'
//		valor = Dec(data)
//		If not (isnull(valor)) then
//			if f_desc_bien(codigo_empresa,valor)='' then
//				f_mensaje("Aviso","No existe el bien.")
//				SetColumn("bien")			
//			End If
//		End If
		
	case 'tipo_bien'		
		cadena = data
		If not isnull(cadena) then
			if f_desc_tipobien(codigo_empresa,cadena)='' then
//				f_mensaje("Aviso","No existe el tipo de amortización.")
//				SetColumn("tipo_bien")			
				Return
			End If
		End If
		If not (isnull(cadena) or trim(cadena)='') then
			  SELECT act_tipobien.requiere_anyo, act_tipobien.tipo_bien  
				 INTO :c1,:c2  
				 FROM act_tipobien  
				WHERE ( act_tipobien.empresa = :codigo_empresa ) AND  
						( act_tipobien.tipo_bien = :cadena )   ;
						
				c1 = trim(c1)
				c2 = trim(c2)
						
				If SQLCA.SQLCode = 0 then
					If isnull(c1) or c1<>'S' then
						requiere_anyo = False
						SetColumn("referencia_tipo")
					Else
						requiere_anyo = True
					End If 
//				Else
//					f_mensaje("Aviso","No existe el tipo de bien.")
//					SetColumn("tipo_bien")					
				End If
		End If


	case 'clase_amor'
		If data='R' then
			n1 = GetItemDecimal(Row,"porcentaje_amor")
			If not isnull(n1) then
				If n1<>0 then
					n2 = 100/n1
					If n2 < 5 then
						n1 = n1 * 3/2
						SetItem(row,"coef_degr",1.5 ) 								 
					elseif n2 < 8 then
							n1 = n1 * 2
							SetItem(row,"coef_degr",2 ) 								 
					 else
							n1 = n1 * 5/2
							SetItem(row,"coef_degr",2.5 ) 								 
					end if	
					SetItem(row,"porcentaje_amor",n1 ) 								 
					SetItem(row,"fiscal",n1 ) 								 
					f_saca_anyos_degr()
				End If
			End IF
		End if

	case 'clase_inmobilizado'
		valor = Dec(data)
		If not isnull(valor) then
			  SELECT act_clase.por_maxlineal,   
						act_clase.por_minlineal,   
						act_clase.cuenta_cargo,   
						act_clase.cuenta_abono  
				 INTO :n1,   
						:n2,   
						:c1,   
						:c2  
				 FROM act_clase  
				WHERE ( act_clase.empresa = :codigo_empresa ) AND  
						( act_clase.clase = :valor )   ;
						
				c1 = trim(c1)
				c2 = trim(c2)
						
				If SQLCA.SQLCode = 0 then
//					n_ant = GetItemDecimal(row,"porcentaje_amor")
					resp = MessageBox("Porcentaje máximo o mínimo","Tenemos la opción de aplicar el porcentaje máximo o mínimo" + char(13) +&
											"¿Desea aplicar el porcentaje máximo?",Question!,YesNo!,1)	
					If resp = 2 then // intercambiar n1 y n2 porque cogemos n1 por defecto
						n3 = n2
						n2 = n1
						n1 = n3
					End If
					
//					If isnull(n_ant) then SetItem(row,"porcentaje_amor",n1) // n1 <- porcentaje_amor
					SetItem(row,"porcentaje_amor",n1) // n1 <- porcentaje_amor
					SetItem(row,"fiscal",n1) // n1 <- porcentaje_amor
//					n_ant = GetItemDecimal(row,"anyos_amor")
//					If isnull(n_ant) then 
					If n1<>0 then
						SetItem(row,"anyos_amor",100/n1)
					Else
						SetItem(row,"anyos_amor",0)
					End If
//					End If
					n3 = GetItemDecimal(Row,"turnos")
					If not isnull(n3) and n3<>1 then
						If resp = 2 then // se ha intercambiado n1 y n2 
							n1 = n1 +((n2 - n1) * n3) // n1 <- porcentaje_amor
							SetItem(row,"porcentaje_amor",n1 ) 
						Else
							n1 = n2 +((n1 - n2) * n3) // n1 <- porcentaje_amor
							SetItem(row,"porcentaje_amor",n1 ) 
						End If
					End If
					c3 = trim(GetItemString(Row,"clase_amor"))
					If not isnull(c3) then
						If c3='R' then
							If n1<>0 then
								n2 = 100/n1
							Else
								n2 = 0
							End If
							If n2<>0 then
								If n2 < 5 then
									n1 = n1 * 3/2
									SetItem(row,"coef_degr",1.5 )
								elseif n2 < 8 then
										n1 = n1 * 2
										SetItem(row,"coef_degr",2 )
									 else
										n1 = n1 * 5/2
										SetItem(row,"coef_degr",2.5 )
								end if	
								SetItem(row,"porcentaje_amor",n1 ) 								 
								f_saca_anyos_degr()
							End IF
						End if
					end IF					
				Else
//					f_mensaje("Aviso","No existe la clase de inmobilizado.")
//					SetColumn("clase_inmobilizado")					
				End If
//				n_ant = GetItemDecimal(row,"fiscal")
//				If isnull(n_ant) then SetItem(row,"fiscal",n1)
				SetItem(row,"fiscal",n1)
//				c_ant = trim(GetItemString(row,"cuenta_cargo"))
//				If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"cuenta_cargo",c1)

				//MARCOS 13/11/19
				//SetItem(row,"cuenta_cargo",c1)
				
//				c_ant = trim(GetItemString(row,"cuenta_abono"))
//				If isnull(c_ant) or trim(c_ant)='' then SetItem(row,"cuenta_abono",c2)

				//MARCOS 13/11/19
				//SetItem(row,"cuenta_abono",c2)	
				
				If c3<>'R' then f_calcula_fin_amort()
				sel = "SELECT coste FROM costesmapa " +& 
				   	"WHERE ( costesmapa.ejercicio = " + uo_ejercicio.em_ejercicio.text + ") and " +& 
         			"( costesmapa.empresa = '" + codigo_empresa + "') and " +&
         			"( costesmapa.cuenta  = '" + c1 + "') " 
				//ds_costes = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, ds_costes)
				If ds_costes.RowCount()>0 then
					SetItem(Row,"centro_coste",string(ds_costes.Object.coste[1]))
				End If

		End If
		
//	case 'ctaproveedor'
//		cuenta = data
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta del proveedor.")
//				SetColumn("ctaproveedor")			
//			end if
//		End If

	case 	'fechacompra'
		If not isnull(data) then 
			fecha = DateTime(mdy(Dec(mid(data,6,2)),Dec(mid(data,9,2)),Dec(mid(data,1,4))))
			SetItem(Row,"fechainamor",fecha)
			SetItem(Row,"anyo1amor",Year(date(fecha)))
			SetItem(Row,"mes1amor",Month(date(fecha)))			
			f_calcula_fin_amort()
		End If
		
	case 'fechainamor'
		If isnull(data) then 
			fecha = GetItemDateTime(Row,"fechacompra")		
			SetItem(Row,"fechainamor",fecha)
		Else
			fecha = DateTime(mdy(Dec(mid(data,6,2)),Dec(mid(data,9,2)),Dec(mid(data,1,4))))
		End If
		SetItem(Row,"anyo1amor",Year(date(fecha)))
		SetItem(Row,"mes1amor",Month(date(fecha)))
		f_calcula_fin_amort()		
		
	case 'anyo1amor'
		f_calcula_fin_amort()		

	case 'mes1amor'
		f_calcula_fin_amort()		
	
	case 'porcentaje_amor'
		valor = Dec(data)
		// 1º ponemos el valor de los años correspondientes a ese porcentage
		If isnull(valor) or valor = 0 then
			SetItem(Row,"anyos_amor",0)
		Else
			SetItem(Row,"anyos_amor",100/valor)
		end if
		c3 = trim(GetItemString(Row,"clase_amor"))
		If not isnull(c3) then
			If c3<>'R' then
				f_calcula_fin_amort()		
			ELse
				f_saca_anyos_degr()
			End IF
		End IF
		c2 = Trim(GetItemString(Row,"tipo_bien"))
		If not isnull(c2) then
			If c2='NO' then SetItem(Row,"fiscal",valor)
		End IF
		
//		valor = DEC(data)
//		// cálculo de anyo2amor
//		If valor <>0 then
//			n1 = 100 / valor
//			n2 = n1 * valor
//			If n2<100 then n1 = n1 + 1
//			n3 = GetItemDecimal(Row,"anyo1amor")				
//			SetItem(Row,"anyo2amor",n3 + n1)
//		End If	
//		// cálculo de mes2amor
//		valor = valor / 12
//		If valor <> 0 then
//			n1 = 100 / valor
//			n2 = n1 * valor
//			If n2<100 then n1 = n1 + 1
//			n2 = GetItemDecimal(Row,"anyo1amor")
//			n3 = GetItemDecimal(Row,"mes1amor")
//			n4 = GetItemDecimal(Row,"anyo2amor")
//			valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
//			If valor < 1 then
//				valor = valor + 12
//				n4 = n4 - 1 
//				SetItem(Row,"anyo2amor",n4)
//			End If
//			SetItem(Row,"mes2amor",valor)			
//		Else
//			SetItem(Row,"mes2amor",0)			
//		End If
	
		
	case 'fiscal'
		valor = Dec(data)
		If isnull(valor) then 
			valor = GetItemDecimal(Row,"clase_amor")		
			SetItem(Row,"fiscal",valor)
		End If		
		
/*	case 'mes2amor'
		valor = GetItemDecimal(Row,"porcentaje_amor")		
		n1 = 100 / valor
		n2 = n1 * valor
		If n2<100 then n1 = n1 + 1
		n3 = GetItemDecimal(Row,"anyo1amor")				
		SetItem(Row,"anyo2amor",n3 + n1)
		
	case 'cuenta_activo'
		valor = GetItemDecimal(Row,"porcentaje_amor")
		valor = valor / 12
		If valor <> 0 then
			n1 = 100 / valor
			n2 = n1 * valor
			If n2<100 then n1 = n1 + 1
			n2 = GetItemDecimal(Row,"anyo1amor")
			n3 = GetItemDecimal(Row,"mes1amor")
			n4 = GetItemDecimal(Row,"anyo2amor")
			valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
			If valor < 1 then
				valor = valor + 12
				n4 = n4 - 1 
				SetItem(Row,"anyo2amor",n4)
			End If
			SetItem(Row,"mes2amor",valor)			
		Else
			SetItem(Row,"mes2amor",0)			
		End If
*/		
//	case 'cuenta_activo'
//		cuenta = data
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de activo.")
//				SetColumn("cuenta_activo")			
//			end if
//		End If



//MARCOS 13/11/19	
	case 'cuenta_activo'
		
		valor = DEC(data)
		SELECT contaplan.cuenta_cargo,   
				 contaplan.cuenta_abono 
		INTO :c1,:c2  	
		FROM contaplan 
		WHERE ( contaplan.empresa = :codigo_empresa ) AND  
				( contaplan.cuenta = :valor ) and ejercicio = :uo_ejercicio.em_ejercicio.text ;
									
		c1 = trim(c1)
		c2 = trim(c2)
				
		SetItem(row,"cuenta_cargo",c1)
		SetItem(row,"cuenta_abono",c2)	
							
	case 'cuenta_cargo'
		cuenta = data
		If not (isnull(cuenta) or trim(cuenta)='') then
			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de cargo.")
//				SetColumn("cuenta_cargo")	
			Else
				sel = "SELECT coste FROM costesmapa " +& 
				   	"WHERE ( costesmapa.ejercicio = " + uo_ejercicio.em_ejercicio.text + ") and " +& 
         			"( costesmapa.empresa = '" + codigo_empresa + "') and " +&
         			"( costesmapa.cuenta  = '" + cuenta + "') " 
				//ds_costes = f_cargar_cursor(sel)
				f_cargar_cursor_nuevo(sel, ds_costes)
				If ds_costes.RowCount()>0 then
					SetItem(Row,"centro_coste",string(ds_costes.Object.coste[1]))
				End If
			end if
		End If
		
//	case 'cuenta_abono'
//		cuenta = data
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
//				f_mensaje("Aviso","No existe la cuenta de abono.")
//				SetColumn("cuenta_abono")			
//			end if
//		End If

//	case 'centro_coste'
//		cuenta = data
//		If not (isnull(cuenta) or trim(cuenta)='') then
//			cadena = f_nombre_costesplan(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta)
//			If isnull(cadena) or trim(cadena)='' then 
//				f_mensaje("Aviso","No existe el centro de coste.")
//				SetColumn("centro_coste")			
//			end if
//		End If
		
	case 'importe','amor_acumulada','coef_degr',"tipo_amor"
		c3 = trim(GetItemString(Row,"clase_amor"))
		If not isnull(c3) then
			If c3='R' then
				f_saca_anyos_degr()
			End IF
		End IF
		
	case 'cuota_amor'
		valor = Dec(data)
		n1 = GetItemDecimal(Row,"porcentaje_amor")
		If ((isnull(valor)) or (valor = 0)) and n1<>0 then
			cadena = trim(GetItemString(Row,"tipo_amor"))
			n3 = GetItemDecimal(Row,"importe")
			choose case cadena
				case 'A'
					valor = n3 * n1 /100
				case 'S'
					valor = (n3 * n1 /100)/2
				case 'T'
					valor = (n3 * n1 /100)/4
				case 'M'
					valor = (n3 * n1 /100)/12
			end choose
			SetItem(Row,"cuota_amor",valor)						
		End If
	
	
		
end choose		

destroy ds_costes
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_act_bienesdet
integer x = 18
integer y = 148
integer width = 242
string text = "Código"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_act_bienesdet
integer x = 1902
integer y = 144
integer width = 302
end type

event cb_insertar::clicked;String var_descripcion,cadena,cuenta,nulo,c1,c2,c3,c4,c5,c6,c7
Integer fila,resp
Dec	valor,calculo,n1,n2,n3,n4,años
Boolean	editando
DateTime	fecha



fila = dw_1.GetRow() 
editando = False

IF fila <> 0 Then
  	 if cb_insertar.enabled = TRUE THEN
		 editando = True	
		 dw_1.AcceptText()

	//	Validaciones
	
		 var_descripcion  = trim(dw_1.GetItemString(fila,"descripcion"))
		 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
			f_mensaje("Aviso","Campo Descripción obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("descripcion")
			Return
		 END IF

		cadena = trim(dw_1.GetItemString(fila,"familia"))
		If not (isnull(cadena) or trim(cadena)='') then
			cadena = f_desc_familia(codigo_empresa,cadena)
				If cadena = '' then f_mensaje("Aviso","No existe la familia.")
		Else
			f_mensaje("Aviso","Campo Familia obligatorio.")
		End If
		If isnull(cadena) or trim(cadena)='' then
			dw_1.SetFocus()
			dw_1.SetColumn("familia")			
			Return
		End If
		
		valor = dw_1.GetItemDecimal(fila,"bien")
		If not (isnull(valor)) then
			if f_desc_bien(codigo_empresa,valor)='' then
				f_mensaje("Aviso","No existe el bien.")
				dw_1.SetFocus()
				dw_1.SetColumn("bien")			
				Return
			End If
		End If
		
		cadena = trim(dw_1.GetItemString(fila,"tipo_bien"))
		If not (isnull(cadena) or trim(cadena)='') then
			  SELECT act_tipobien.requiere_anyo, act_tipobien.tipo_bien  
				 INTO :c1,:c2  
				 FROM act_tipobien  
				WHERE ( act_tipobien.empresa = :codigo_empresa ) AND  
						( act_tipobien.tipo_bien = :cadena )   ;
						
				c1 = trim(c1)
				c2 = trim(c2)
						
				If SQLCA.SQLCode = 0 then
					If not (isnull(c1) or c1<>'S') then
						n1 = dw_1.GetItemdecimal(fila,"anyo_tipo")
						If isnull(n1) then
							f_mensaje("Aviso","El tipo de bien requiere año.")
							dw_1.SetFocus()
							dw_1.SetColumn("anyo_tipo")			
							Return
						end if
					End If 
				End If
		Else
			c3 = trim(dw_1.GetItemString(fila,"clase_inmobilizado"))
			If isnull(c3) or trim(c3)='' then
				f_mensaje("Aviso","El tipo de bien y la clase de inmobilizado no pueden ser nulos a la vez.")
				dw_1.SetFocus()
				dw_1.SetColumn("clase_inmobilizado")			
				Return
			end if
		End If

		valor = dw_1.GetItemDecimal(fila,"turnos")
		If isnull(valor) then
			f_mensaje("Aviso","Campo Turnos obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("turnos")			
			Return
		end if
		
		cadena = trim(dw_1.GetItemString(fila,"clase_amor"))
		If isnull(cadena) or trim(cadena)='' then
			f_mensaje("Aviso","Campo Clase de Amortización obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("clase_amor")			
			Return
		end if
		
		valor = dw_1.GetItemDecimal(fila,"clase_inmobilizado")
		If isnull(valor) then
			f_mensaje("Aviso","Campo Clase de Inmovilizado obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("clase_inmobilizado")			
			Return			
		Else			
			  SELECT act_clase.por_maxlineal,   
						act_clase.por_minlineal,   
						act_clase.cuenta_cargo,   
						act_clase.cuenta_abono  
				 INTO :n1,   
						:n2,   
						:c1,   
						:c2  
				 FROM act_clase  
				WHERE ( act_clase.empresa = :codigo_empresa ) AND  
						( act_clase.clase = :valor )   ;
						
				c1 = trim(c1)
				c2 = trim(c2)

						
				If SQLCA.SQLCode = 0 then										
					n3 = dw_1.GetItemDecimal(fila,"porcentaje_amor")
					if isnull(n3) then 
						resp = MessageBox("Porcentaje máximo o mínimo","Tenemos la opción de aplicar el porcentaje máximo o mínimo" + char(13) +&
												"¿Desea aplicar el porcentaje máximo?",Question!,YesNo!,1)	
						If resp = 2 then // intercambiar n1 y n2 porque cogemos n1 por defecto
							n3 = n2
							n2 = n1
							n1 = n3
						End If
						dw_1.SetItem(fila,"porcentaje_amor",n1) // n1 <- porcentaje_amor
						If n1<>0 then
							dw_1.SetItem(fila,"anyos_amor",100/n1)
						Else
							dw_1.SetItem(fila,"anyos_amor",0)
						End If
						n3 = dw_1.GetItemDecimal(fila,"turnos")
						If not isnull(n3) and n3<>1 then
							If resp = 2 then // hemos intercambiado n1 y n2 
								n1 = n1 +((n2 - n1) * n3) // n1 <- porcentaje_amor
							Else
								n1 = n2 +((n1 - n2) * n3) // n1 <- porcentaje_amor
							End If
							dw_1.SetItem(fila,"porcentaje_amor",n1 ) 
						End If
						c3 = trim(dw_1.GetItemString(fila,"clase_amor"))
						If not isnull(c3) then
							If c3='R' then
								n2 = dw_1.GetItemDecimal(fila,"anyos_amor")
								If not isnull(n2) then
									If n2 < 5 then
										n1 = n1 * 3/2
									elseif n2 < 8 then
											n1 = n1 * 2
										 else
											n1 = n1 * 5/2
									end if	
									dw_1.SetItem(fila,"porcentaje_amor",n1 ) 								 
								End IF
							End if
						end IF					
					end if
				Else
					f_mensaje("Aviso","No existe la clase de inmovilizado.")
					dw_1.SetFocus()
					dw_1.SetColumn("clase_inmobilizado")					
					Return
				End If
				n4 = dw_1.GetItemDecimal(fila,"fiscal")
				if isnull(n4) then dw_1.SetItem(fila,"fiscal",n1)
				cuenta = trim(dw_1.GetItemString(fila,"cuenta_cargo"))
				If isnull(cuenta) or trim(cuenta)='' then dw_1.SetItem(fila,"cuenta_cargo",c1)
				cuenta = trim(dw_1.GetItemString(fila,"cuenta_abono"))
				If isnull(cuenta) or trim(cuenta)='' then dw_1.SetItem(fila,"cuenta_abono",c2)
		End If

		cuenta = trim(dw_1.GetItemString(fila,"ctaproveedor"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta del proveedor.")
			dw_1.SetFocus()
			dw_1.SetColumn("ctaproveedor")			
			Return
		end if
		
		cadena = trim(dw_1.GetItemString(fila,"factura"))
		If isnull(cadena) or trim(cadena) = ''then
			f_mensaje("Aviso","Campo Factura obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("factura")			
			Return
		end if
		
		fecha = dw_1.GetItemDateTime(fila,"fechacompra")
		If isnull(fecha) then
			f_mensaje("Aviso","Campo Fecha Compra obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("fechacompra")			
			Return
		end if
		
		valor = dw_1.GetItemDecimal(fila,"importe")
		If isnull(valor) then
			f_mensaje("Aviso","Campo Importe obligatorio.")
			dw_1.SetFocus()
			dw_1.SetColumn("importe")			
			Return
		end if

		fecha = dw_1.GetItemDateTime(fila,"fechainamor")
		If isnull(fecha) then
			fecha = dw_1.GetItemDateTime(fila,"fechacompra")
			dw_1.SetItem(fila,"fechainamor",fecha)			
		end if

		valor = dw_1.GetItemDecimal(fila,"fiscal")
		If isnull(valor) then
			valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")
			dw_1.SetItem(fila,"fiscal",valor)			
			Return
		end if
		
		c3 = trim(dw_1.GetItemString(fila,"clase_amor"))
		If not isnull(c3) then
			If c3='R' then
				valor = dw_1.GetItemDecimal(fila,"coef_degr")
				If isnull(valor) or valor = 0 then
					f_mensaje("Aviso","Campo Coef. obligatorio para el cálculo de las amortizaciones degresivas.")
					dw_1.SetFocus()
					dw_1.SetColumn("coef_degr")			
					Return
				End If				
				f_saca_anyos_degr()
			Else
				valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")
				If isnull(valor) or valor = 0 then
					dw_1.SetItem(fila,"anyos_amor",0)			
				Else
					dw_1.SetItem(fila,"anyos_amor",100/valor)			
				End If
				f_calcula_fin_amort()		
			End IF
		End IF



//		fecha = dw_1.GetItemDateTime(fila,"fechainamor")		
//		valor = dw_1.GetItemDecimal(fila,"anyo1amor")
//		If isnull(valor) then dw_1.SetItem(fila,"anyo1amor",Year(date(fecha)))
//		valor = dw_1.GetItemDecimal(fila,"mes1amor")
//		If isnull(valor) then dw_1.SetItem(fila,"mes1amor",Month(date(fecha)))
//		
//		valor = dw_1.GetItemDecimal(fila,"anyo2amor")
//		If isnull(valor) then 
//			valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")		
//			If valor <>0 then
//				n1 = 100 / valor
//				n2 = n1 * valor
//				If n2<100 then n1 = n1 + 1
//				n3 = dw_1.GetItemDecimal(fila,"anyo1amor")				
//				dw_1.SetItem(fila,"anyo2amor",n3 + n1)
//			End If	
//		End If
//
//		valor = dw_1.GetItemDecimal(fila,"mes2amor")
//		If isnull(valor) then 
//			valor = dw_1.GetItemDecimal(fila,"porcentaje_amor")		
//			valor = valor / 12
//			If valor <> 0 then
//				n1 = 100 / valor
//				n2 = n1 * valor
//				If n2<100 then n1 = n1 + 1
//				n2 = dw_1.GetItemDecimal(fila,"anyo1amor")
//				n3 = dw_1.GetItemDecimal(fila,"mes1amor")
//				n4 = dw_1.GetItemDecimal(fila,"anyo2amor")
//				valor = n1 - (((n4 - n2 - 1 ) * 12) + ( 13 - n3))
//				If valor < 1 then
//					valor = valor + 12
//					n4 = n4 - 1 
//					dw_1.SetItem(fila,"anyo2amor",n4)
//				ElseIf valor > 12 then
//					valor = valor - 12
//					n4 = n4 + 1 
//					dw_1.SetItem(fila,"anyo2amor",n4)
//				End If
//				dw_1.SetItem(fila,"mes2amor",valor)			
//			Else
//				dw_1.SetItem(fila,"mes2amor",0)			
//			End If
//		End If
	
		cuenta = trim(dw_1.GetItemString(fila,"cuenta_activo"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de activo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_activo")			
			Return
		end if
		
		cuenta = trim(dw_1.GetItemString(fila,"cuenta_cargo"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de cargo.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_cargo")			
			Return
		end if
		
		cuenta = trim(dw_1.GetItemString(fila,"cuenta_abono"))
		If isnull(cuenta) then cuenta=''
		if not f_existe_cuenta(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta) then
			f_mensaje("Aviso","No existe la cuenta de abono.")
			dw_1.SetFocus()
			dw_1.SetColumn("cuenta_abono")			
			Return
		end if

		cuenta = trim(dw_1.GetItemString(fila,"centro_coste"))
		If not (isnull(cuenta) or trim(cuenta)='') then
			cadena = f_nombre_costesplan(dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cuenta)
			If isnull(cadena) or trim(cadena)='' then 
				f_mensaje("Aviso","No existe el centro de coste.")
				dw_1.SetFocus()
				dw_1.SetColumn("centro_coste")			
				Return
			end if
		End If

		valor = dw_1.GetItemDecimal(fila,"cuota_amor")
		n1 = dw_1.GetItemDecimal(fila,"porcentaje_amor")
		If ((isnull(valor)) or (valor = 0)) and n1<>0 then
			cadena = trim(dw_1.GetItemString(fila,"tipo_amor"))
			n3 = dw_1.GetItemDecimal(fila,"importe")
			choose case cadena
				case 'A'
					valor = n3 * n1 /100
				case 'S'
					valor = (n3 * n1 /100)/2
				case 'T'
					valor = (n3 * n1 /100)/4
				case 'M'
					valor = (n3 * n1 /100)/12
			end choose
			dw_1.SetItem(fila,"cuota_amor",valor)						
		End If
		
		cadena = dw_1.GetItemString(fila,"ubicacion")
		If not (isnull(valor)) then
			if f_desc_ubicacion(codigo_empresa,cadena)='' then
				f_mensaje("Aviso","No existe la ubicación.")
				dw_1.SetFocus()
				dw_1.SetColumn("ubicacion")			
				Return
			End If
		End If
		
		n1 = dw_1.GetItemDecimal(fila,"importe")
		If isnull(n1) then n1 = 0
		n2 = dw_1.GetItemDecimal(fila,"amor_acumulada")
		If isnull(n2) then n2 = 0
		dw_1.SetItem(fila,"restoprevisto",0)

		
	end if 
END IF


CALL super::Clicked

if not editando THEN //Inicializaciones
	dw_1.SetItem(dw_1.GetRow(),"clase_amor",'L')
	dw_1.SetItem(dw_1.GetRow(),"tipo_amor",'A')
	dw_1.SetItem(dw_1.GetRow(),"turnos",1)
	dw_1.SetItem(dw_1.GetRow(),"tipo_bien",'NO') 
	SetNull(nulo)
	dw_1.SetItem(dw_1.GetRow(),"anyo_tipo", nulo)
End If
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_act_bienesdet
integer x = 2213
integer y = 144
integer width = 302
end type

event cb_borrar::clicked;DateTime 		fecha
Dec				amort,elemento
Str_Parametros	lstr_param

IF not isnull(sle_valor.text) and trim(sle_valor.text)<>'' then
	fecha = dw_1.GetItemDateTime(dw_1.GetRow(),"fechabaja")	
	If not isnull(fecha) then
		f_mensaje("Error","El Elemento no puede borrarse porque ha sido dado de baja.")
		return
	Else
		elemento = dec(sle_valor.text)
		  SELECT act_amortizaciones.amortizacion  
			 INTO :amort  
			 FROM act_amortizaciones  
			WHERE ( act_amortizaciones.empresa = :codigo_empresa) AND  
					( act_amortizaciones.elemento = :elemento ) AND  
					( act_amortizaciones.actualizado = 'S' )   ;
			If Sqlca.Sqlcode=0 then
				f_mensaje("Error","El Elemento no puede borrarse porque tiene amortizaciones actualizadas.")
			Else		
				call super::clicked
				// BORRAMOS LAS AMORTIZACIONES GENERADAS
				 DELETE FROM act_amortizaciones  
				WHERE ( act_amortizaciones.empresa = :codigo_empresa) AND  
						( act_amortizaciones.elemento = :elemento ) ;				
			End If
	End If 
End If 
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_act_bienesdet
integer x = 274
integer y = 144
integer width = 471
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
   isle_campo        = This
	valor_empresa		= True
end event

event sle_valor::busqueda;/*
str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text = ue_valor
f_buscar(This,param)
This.TriggerEvent("modificado")
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))

/////////////////////////
*/




String consulta_busqueda, prueba
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT act_bienesdet.elemento, act_bienesdet.descripcion, act_bienesdet.fechacompra, act_bienesdet.cuenta_activo "+&
							"FROM act_bienesdet "


busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"
busqueda.titulos[3] = "Fecha Compra"
busqueda.titulos[4] = "CTA Activo"

this.text = Trim(ue_valor)
IF not isnull(this.text) and this.text <> "" THEN
	busqueda.filtro = this.text
	if Long(this.text) = 0 then
		//Es texto
		//busqueda.filtro = this.text
		busqueda.filtro_es_codigo = false
	else
		//Es código
		busqueda.filtro_es_codigo = true
	end if
END IF
OpenWithParm(wt_busquedas, busqueda)
resultado = Message.PowerObjectParm
if resultado.resultado = -1 then
	MessageBox("Error en la creación de la búsqueda",resultado.error)
	return
elseif resultado.resultado > 0 then
	this.text = resultado.valores[1]
end if
This.TriggerEvent("modificado")
ue_ante_valor = Trim(this.text)
This.SelectText(1,Len(This.Text))

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_act_bienesdet
integer x = 2523
integer y = 144
integer width = 302
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_act_bienesdet
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_act_bienesdet
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_act_bienesdet
integer y = 20
integer width = 2811
end type

type pb_calculadora from u_calculadora within wi_mant_act_bienesdet
integer x = 759
integer y = 144
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From act_bienesdet
 Where  act_bienesdet.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(act_bienesdet.elemento+1)
  Into   :sle_valor.text
  From   act_bienesdet
  Where  act_bienesdet.empresa = :codigo_empresa;
END IF
 dw_1.TriggerEvent("Clicked")
end event

type cb_amort from u_boton within wi_mant_act_bienesdet
integer x = 1545
integer y = 144
integer width = 302
integer height = 92
integer taborder = 0
string text = "Amort."
end type

event clicked;call super::clicked;str_parametros lstr_param

IF not isnull(sle_valor.text) and trim(sle_valor.text)<>'' then
	lstr_param.i_nargumentos = 2
	lstr_param.s_argumentos[1] = "wi_mant_act_bienesdet"
	lstr_param.s_argumentos[2] = sle_valor.text
	OpenWithParm(w_con_act_amortizaciones,lstr_param)
End If
end event

type uo_ejercicio from u_ejercicio within wi_mant_act_bienesdet
integer x = 882
integer y = 144
integer taborder = 20
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type dw_2 from datawindow within wi_mant_act_bienesdet
boolean visible = false
integer x = 1239
integer y = 928
integer width = 1527
integer height = 376
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_con_obs_elementos"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;str_parametros lstr_param

If not isnull(dwo) then
	If dwo.name = "pb_salir" then
		dw_2.visible = false
	End IF
	If dwo.name = "pb_carpeta" then	
	   lstr_param.i_nargumentos=2
	   lstr_param.s_argumentos[2]=sle_valor.text
		OpenWithParm(wi_mant_act_obs_elementos,lstr_param)  
	End IF

End If
end event

