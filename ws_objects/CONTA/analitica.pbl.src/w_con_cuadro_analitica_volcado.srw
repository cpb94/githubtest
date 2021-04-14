$PBExportHeader$w_con_cuadro_analitica_volcado.srw
$PBExportComments$€
forward
global type w_con_cuadro_analitica_volcado from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_cuadro_analitica_volcado
end type
type em_nivel from editmask within w_con_cuadro_analitica_volcado
end type
type em_nivel_coste from editmask within w_con_cuadro_analitica_volcado
end type
type dw_listado from datawindow within w_con_cuadro_analitica_volcado
end type
type dw_1 from datawindow within w_con_cuadro_analitica_volcado
end type
type uo_bal from u_em_campo_2 within w_con_cuadro_analitica_volcado
end type
type st_55 from statictext within w_con_cuadro_analitica_volcado
end type
type st_66 from statictext within w_con_cuadro_analitica_volcado
end type
type st_77 from statictext within w_con_cuadro_analitica_volcado
end type
type cb_consulta from u_boton within w_con_cuadro_analitica_volcado
end type
type pb_imprimir_preli from picturebutton within w_con_cuadro_analitica_volcado
end type
type cb_grabar from u_boton within w_con_cuadro_analitica_volcado
end type
type uo_1 from u_selec_impresoras within w_con_cuadro_analitica_volcado
end type
type st_cuenta from statictext within w_con_cuadro_analitica_volcado
end type
type uo_cuenta from u_em_campo_2 within w_con_cuadro_analitica_volcado
end type
type cb_cuenta from commandbutton within w_con_cuadro_analitica_volcado
end type
type cb_cuenta2 from commandbutton within w_con_cuadro_analitica_volcado
end type
type pb_33 from picturebutton within w_con_cuadro_analitica_volcado
end type
type dw_fam from datawindow within w_con_cuadro_analitica_volcado
end type
end forward

global type w_con_cuadro_analitica_volcado from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3045
integer height = 2072
string title = "Consulta de Movimientos"
pb_2 pb_2
em_nivel em_nivel
em_nivel_coste em_nivel_coste
dw_listado dw_listado
dw_1 dw_1
uo_bal uo_bal
st_55 st_55
st_66 st_66
st_77 st_77
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
cb_grabar cb_grabar
uo_1 uo_1
st_cuenta st_cuenta
uo_cuenta uo_cuenta
cb_cuenta cb_cuenta
cb_cuenta2 cb_cuenta2
pb_33 pb_33
dw_fam dw_fam
end type
global w_con_cuadro_analitica_volcado w_con_cuadro_analitica_volcado

type variables
Dec hoja,ul_nivel_cta,ul_nivel_coste,ultima
String vn,mod
string cos
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_limpiar ()
public subroutine f_mascara ()
public subroutine f_valores (integer j)
public subroutine f_eti ()
public subroutine f_calculo (datawindow data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Dec       nivel,digitos,ejer,dig[],digotos_cta,vimporte,j,xx,j2,h,v,suma,i
Boolean bus
DateTime  fechad,fechah
STring vcoste,vcuenta,vnombre,vtitulo,ante_coste




cos = ""
for i = 1 to dw_fam.rowcount()
		if dw_fam.getitemstring(i,"marca")="S" then
			IF Trim(cos) = "" Then
				cos = "('"+dw_fam.getitemstring(i,"coste")+"'"
			ELSE
				cos = cos +",'"+dw_fam.getitemstring(i,"coste")+"'"
			END IF

			
		end if
next
cos = cos + ")"





dw_data.SetRedraw(FALSE)

SetPointer(HourGlass!)

dw_data.Reset()

nivel = Dec(em_nivel.text)

IF Dec(em_nivel_coste.text) = 1 Then
	digitos  = f_digitos_analitica_primer_nivel()
ELSE
	digitos  = f_digitos_analitica_segundo_nivel()
END IF
ejer = ejercicio_Activo

  SELECT contaparam.digitos1,   
         contaparam.digitos2,   
         contaparam.digitos3,   
         contaparam.digitos4,   
         contaparam.digitos5,   
         contaparam.digitos6,   
         contaparam.digitos7,   
         contaparam.digitos8,   
         contaparam.digitos9  
    INTO :dig[1],   
         :dig[2],   
         :dig[3],   
         :dig[4],   
         :dig[5],   
         :dig[6],   
         :dig[7],   
         :dig[8],   
         :dig[9]  
    FROM contaparam  
   WHERE contaparam.ejercicio  = :ejer
	AND   contaparam.empresa    = :codigo_empresa;
		
digotos_cta  =  dig[nivel]		

IF ul_nivel_coste = digitos and ul_nivel_cta = digotos_cta Then
	mod = "S"
ELSE
	mod = "N"
END IF
//f_mensaje("",cos)
String sel
Datastore  dw
Sel = +&
  " SELECT SubString(costesapuman.coste,1,"  + STring(digitos,"###############")+") cost ,       "  +&
  "        SubString(costesapuman.cuenta,1," + String(digotos_cta,"##############") + ") cta,    "  +&
  "        Sum(importe) imp  "    + &
  " FROM costesapuman"  + &
  " WHERE ( costesapuman.codigo = '"+uo_bal.em_codigo.text+"')  and " + &
  "       (  costesapuman.empresa = '"       + codigo_empresa   + "' ) "  +&
  " And  coste IN "+cos+&
  "   GROUP BY SubString(costesapuman.coste,1," + String(digitos,"##############") + "),"  +&
  "   SubString(costesapuman.cuenta,1,"       + String(digotos_cta,"#############")+")  "  +&
  " ORDER BY SubString(costesapuman.coste,1," + String(digitos)+") ASC,      "  +&
  "          SubString(costesapuman.cuenta,1,"+ String(digotos_cta,"#############")+") ASC  "   
//	f_mensaje("",sel)
//  dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
  ante_coste = ""
  j2 = 0
  For xx = 1 To dw.Rowcount()
	vcoste   = dw.GetItemString(xx,1)
	vcuenta  = dw.GetItemString(xx,2)
	vimporte = dw.GetItemNumber(xx,3)
	vtitulo  = f_nombre_contaplan(ejercicio_activo,codigo_empresa,vcuenta)
	vnombre  = f_nombre_costesplan_abr(ejercicio_activo,codigo_empresa,vcoste)
	bus = TRUE
	// Buscar fila
	IF dw_data.RowCOunt() = 0 Then
		bus = FALSE
	ELSE
		j = dw_data.find("codigo_cuenta = '"+vcuenta+"'",1,dw_data.RowCOunt()) 
		IF j = 0 Then bus = FALSE
	END IF
	
	// Si no esta la fila a esa cuenta inserto
		IF NOt bus Then j = dw_data.InsertRow(0)
		dw_data.Object.cuenta[j] = vtitulo
		IF vcuenta = "Z1" Then
			dw_data.SetItem(j,"cal","2")
		ELSE
			dw_data.SetItem(j,"cal","1")
		END IF
		
		dw_data.Object.codigo_cuenta[j] = vcuenta
		IF ante_coste <> vcoste Then
			j2 ++
		END IF
		dw_data.SetItem(1,Trim("fila"+STring(j2,"##")),vnombre)
		dw_data.SetItem(1,Trim("codigo_fila"+STring(j2,"##")),vcoste)
		dw_data.SetItem(j,Trim("importe"+STring(j2,"##")),vimporte)
		dw_data.SetItem(j,"mod",mod)
		ante_coste = vcoste
  Next
  
  
  iF em_nivel_coste.text = "2" Then
			//---------------------------------------------------------------------
			// Columna de kilos
			//---------------------------------------------------------------------
		j = dw_data.find("codigo_cuenta = 'Z1'",1,dw_data.RowCOunt()) 
		IF j = 0 Then j = dw_data.InsertRow(0)
		  		dw_data.Object.cuenta[j] = "TOTAL KILOS"
				dw_data.SetItem(j,"cal","2")
				
				dw_data.Object.codigo_cuenta[j] = "Z1"
				dw_data.SetItem(j,Trim("importe"+STring(j2,"##")),0)
 			   dw_data.SetItem(j,"mod",mod)

		  //---------------------------------------------------------------------
  END IF
  
  ultima = j2
  
 f_mascara_columna(dw_data,Trim("importe"+STring(ultima +1,"##")),f_mascara_decimales(2))  
 
  For j = 1 To dw_data.RowCount()
		suma = 0
		For h= 1 To ultima 
			suma = suma + dw_data.GetItemNumber(j,"importe"+STring(h,"##"))
			dw_data.SetItem(j,Trim("fila"+STring(h,"##")),dw_data.GetItemSTring(1,"fila"+STring(h,"##")))
			dw_data.SetItem(j,Trim("codigo_fila"+STring(h,"##")),dw_data.GetItemSTring(1,"codigo_fila"+STring(h,"##")))
			dw_data.SetItem(j,Trim("fila"+STring(ultima +1,"##")),"Total")
			IF j = 1 Then 
				dw_data.SetItem(1,"mod",mod)
				f_mascara_columna(dw_data,Trim("importe"+STring(h,"##")),f_mascara_decimales(2))
//				f_mascara_columna(dw_data,Trim("t"+STring(h,"##")),f_mascara_decimales(0))
			END IF
		Next
		dw_data.SetItem(j,"importe"+STring(ultima +1,"##"),suma)
  Next

  For v = ultima +2 To 70
		// invisible
		dw_data.Modify("fila"+STring(v,"##") + ".Visible=0")
		dw_data.Modify("importe"+STring(v,"##") + ".Visible=0")
		dw_data.Modify("t"+STring(v,"##") + ".Visible=0")
		dw_data.Modify("fila"+STring(v,"##") + ".x=5")
		dw_data.Modify("importe"+STring(v,"##") + ".x=5")
		dw_data.Modify("t"+STring(v,"##") + ".x=5")
	Next
  dw_data.SetSort("cal,codigo_cuenta")
  dw_data.Sort()
  dw_data.SetRedraw(TRUE)
  f_calculo(dw_data)
  dw_data.GroupCalc()
  SetPointer(Arrow!)
  
IF mod = "S" Then
	cb_grabar.visible = TRUE
	st_cuenta.visible = TRUE
	uo_cuenta.visible = TRUE
	cb_cuenta.visible = TRUE
	cb_cuenta2.visible = TRUE	
ELSE
	cb_grabar.visible = FALSE
	st_cuenta.visible = FALSE
	uo_cuenta.visible = FALSE
	cb_cuenta.visible = FALSE
	cb_cuenta2.visible = FALSE	
END IF

destroy dw
end subroutine

public subroutine f_limpiar ();Dec v,f
 For v = 1 To 8
		For f = 1 To dw_listado.RowCount()
			dw_listado.SetItem(f,"importe"+STring(v,"##"),0)
			f_valores(f)
		Next
		dw_listado.SetItem(1,"fila"+STring(v,"##"),'')
Next
end subroutine

public subroutine f_mascara ();Dec j
For j = 1 To 8
				f_mascara_columna(dw_listado,Trim("importe"+STring(j,"##")),f_mascara_decimales(2))
//				f_mascara_columna(dw_listado,Trim("t"+STring(j,"##")),f_mascara_decimales(0))	
Next
end subroutine

public subroutine f_valores (integer j);Datetime f1,f2
Dec nivelcta,nivelcoste
nivelcta   =  Dec(em_nivel.text)
nivelcoste =  Dec(em_nivel_coste.text)


dw_listado.SetItem(j,"hoja",hoja)
dw_listado.SetItem(j,"empresa",codigo_empresa)
dw_listado.SetItem(j,"nivelcta",nivelcta)
dw_listado.SetItem(j,"nivelcoste",nivelcoste)






end subroutine

public subroutine f_eti ();String v
Dec h,g
For h = 1 to dw_listado.Rowcount()
	For g = 1 To 8
		v = dw_listado.GetItemstring(1,Trim("fila"+STring(g,"##")))
		dw_listado.SetItem(h,Trim("fila"+STring(g,"##")),v)
	Next
Next
end subroutine

public subroutine f_calculo (datawindow data);//Dec j,j2,kilos,total
//Dec{2} pre
//
//j = data.find("codigo_cuenta = 'Z1'",1,data.RowCOunt()) 
//
//For j2 = 1 To 70
//		kilos = data.GetItemNumber(j,Trim("importe"+STring(j2,"##")))
//		total = data.GetItemNumber(1,Trim("t"+STring(j2,"##")))
////		f_mensaje("Total",String(total))
////		f_mensaje("Kilos",String(kilos))
//		IF kilos = 0 Then
//			pre = 0
//		ELSE
//			pre =  total /kilos
//		END IF	
//		data.SetItem(j + 1,Trim("importe"+STring(j2,"##")),pre)
//Next
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;IF Not f_pedir_clave("431") Then
	Close(This)
	Return
END IF
This.title = " CUADRO DE ANALITICA VOLCADO"
dw_1.visible = False
f_activar_campo(uo_bal.em_campo)
Select digitos 
Into   :ul_nivel_cta
From   contaparam
Where  ejercicio = :ejercicio_activo
And    empresa   = :codigo_empresa;

ul_nivel_coste = f_digitos_analitica_segundo_nivel()
st_cuenta.visible = FALSE
uo_cuenta.visible = FALSE
cb_grabar.visible = FALSE
cb_cuenta.visible = FALSE
cb_cuenta2.visible = FALSE



dw_fam.SetTransObject(SQLCA)
dw_fam.retrieve(codigo_empresa)
end event

on w_con_cuadro_analitica_volcado.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_nivel=create em_nivel
this.em_nivel_coste=create em_nivel_coste
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.uo_bal=create uo_bal
this.st_55=create st_55
this.st_66=create st_66
this.st_77=create st_77
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_grabar=create cb_grabar
this.uo_1=create uo_1
this.st_cuenta=create st_cuenta
this.uo_cuenta=create uo_cuenta
this.cb_cuenta=create cb_cuenta
this.cb_cuenta2=create cb_cuenta2
this.pb_33=create pb_33
this.dw_fam=create dw_fam
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_nivel
this.Control[iCurrent+3]=this.em_nivel_coste
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_bal
this.Control[iCurrent+7]=this.st_55
this.Control[iCurrent+8]=this.st_66
this.Control[iCurrent+9]=this.st_77
this.Control[iCurrent+10]=this.cb_consulta
this.Control[iCurrent+11]=this.pb_imprimir_preli
this.Control[iCurrent+12]=this.cb_grabar
this.Control[iCurrent+13]=this.uo_1
this.Control[iCurrent+14]=this.st_cuenta
this.Control[iCurrent+15]=this.uo_cuenta
this.Control[iCurrent+16]=this.cb_cuenta
this.Control[iCurrent+17]=this.cb_cuenta2
this.Control[iCurrent+18]=this.pb_33
this.Control[iCurrent+19]=this.dw_fam
end on

on w_con_cuadro_analitica_volcado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_nivel)
destroy(this.em_nivel_coste)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.uo_bal)
destroy(this.st_55)
destroy(this.st_66)
destroy(this.st_77)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.cb_grabar)
destroy(this.uo_1)
destroy(this.st_cuenta)
destroy(this.uo_cuenta)
destroy(this.cb_cuenta)
destroy(this.cb_cuenta2)
destroy(this.pb_33)
destroy(this.dw_fam)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_cuadro_analitica_volcado
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_cuadro_analitica_volcado
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_cuadro_analitica_volcado
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_cuadro_analitica_volcado
integer x = 2903
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_nivel from editmask within w_con_cuadro_analitica_volcado
integer x = 1056
integer y = 208
integer width = 197
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~3"
end type

type em_nivel_coste from editmask within w_con_cuadro_analitica_volcado
integer x = 1253
integer y = 208
integer width = 224
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean autoskip = true
boolean spin = true
double increment = 1
string minmax = "1~~2"
end type

type dw_listado from datawindow within w_con_cuadro_analitica_volcado
boolean visible = false
integer x = 32
integer y = 320
integer width = 2761
integer height = 936
string dataobject = "report_con_cuadro_analitica_volcado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_cuadro_analitica_volcado
integer x = 32
integer y = 320
integer width = 2853
integer height = 1328
string dataobject = "dw_con_cuadro_analitica_volcado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;iF f_objeto_datawindow(This)= "cal" Then
	f_calculo(This)
End If

IF row = 0 or IsNull(row) Then Return
uo_cuenta.em_codigo.text    =   dw_1.Object.codigo_cuenta[row]
uo_cuenta.em_campo.text     =   dw_1.Object.cuenta[row]
uo_cuenta.ue_valor_anterior =   dw_1.Object.cuenta[row]
IF Object.mod[row] = "N" Then
	f_mensaje("No se puede modificar","Solo ultimo nivel")
	f_activar_campo(uo_bal.em_campo)
	Return
END IF


end event

type uo_bal from u_em_campo_2 within w_con_cuadro_analitica_volcado
event destroy ( )
integer x = 37
integer y = 208
integer width = 1015
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_bal.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_bal.em_campo.text=f_nombre_cosbal(codigo_empresa,uo_bal.em_codigo.text)
If Trim(uo_bal.em_campo.text)="" then
	uo_bal.em_campo.text=""
	uo_bal.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_cosbal"
ue_titulo      = "AYUDA SELECCION DE CUADROS"
ue_filtro      =""
end event

type st_55 from statictext within w_con_cuadro_analitica_volcado
integer x = 37
integer y = 132
integer width = 1019
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Nombre Cuadro"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_66 from statictext within w_con_cuadro_analitica_volcado
integer x = 1056
integer y = 132
integer width = 192
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "N.Cta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_77 from statictext within w_con_cuadro_analitica_volcado
integer x = 1248
integer y = 132
integer width = 219
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "N.Coste"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_consulta from u_boton within w_con_cuadro_analitica_volcado
integer x = 1495
integer y = 128
integer width = 306
integer height = 92
integer taborder = 0
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;dw_1.DataObject = "dw_con_cuadro_analitica_volcado"
dw_1.SetTransObject(SQLCA)
f_cargar(dw_1)
dw_1.visible = TRUE

end event

type pb_imprimir_preli from picturebutton within w_con_cuadro_analitica_volcado
integer x = 1801
integer y = 128
integer width = 110
integer height = 92
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;Dw_listado.DataObject = "report_con_cuadro_analitica"
dw_listado.SetTransObject(SQLCA)


Dec       nivel,digitos,ejer,dig[],digotos_cta,vimporte,j,xx,j2,h,v,suma,f2
Boolean bus
STring vcoste,vcuenta,vnombre,vtitulo,ante_coste
Dec total[10000]
hoja = 1



dw_listado.SetRedraw(TRUE)

SetPointer(HourGlass!)

dw_listado.Reset()

nivel = Dec(em_nivel.text)

IF Dec(em_nivel_coste.text) = 1 Then
	digitos  = f_digitos_analitica_primer_nivel()
ELSE
	digitos  = f_digitos_analitica_segundo_nivel()
END IF

ejer=ejercicio_ACTIVO

  SELECT contaparam.digitos1,   
         contaparam.digitos2,   
         contaparam.digitos3,   
         contaparam.digitos4,   
         contaparam.digitos5,   
         contaparam.digitos6,   
         contaparam.digitos7,   
         contaparam.digitos8,   
         contaparam.digitos9  
    INTO :dig[1],   
         :dig[2],   
         :dig[3],   
         :dig[4],   
         :dig[5],   
         :dig[6],   
         :dig[7],   
         :dig[8],   
         :dig[9]  
    FROM contaparam  
   WHERE contaparam.ejercicio  = :ejer
	AND   contaparam.empresa    = :codigo_empresa;
		
digotos_cta  =  dig[nivel]		
String sel
Datastore  dw
Sel = +&
  " SELECT SubString(costesapuman.coste,1,"  + STring(digitos,"###########")+") cost ,       "  +&
  "        SubString(costesapuman.cuenta,1," + String(digotos_cta,"###########") + ") cta,    "  +&
  "        Sum(importe) imp "  +&
  " FROM costesapuman" +&
  " WHERE ( costesapuman.empresa = '"       + codigo_empresa   + "' )        "  +&
  "  AND   ( costesapuman.codigo  = '"       + Trim(uo_bal.em_codigo.text)  + "' )        "  +&
  "   GROUP BY SubString(costesapuman.coste,1," + String(digitos,"###########") + "),"  +&
  "   SubString(costesapuman.cuenta,1,"       + String(digotos_cta,"###########")+")  "  +&
  " ORDER BY SubString(costesapuman.coste,1," + String(digitos)+") ASC,      "  +&
  "          SubString(costesapuman.cuenta,1,"+ String(digotos_cta,"###########")+") ASC  "   

//  dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
  //------------------------------------------------------------------
  // Componer lineas de cuentas
  //------------------------------------------------------------------
  
  For xx = 1 To dw.Rowcount()
	vcuenta = dw.GetItemString(xx,2)
	vtitulo = f_nombre_contaplan(ejercicio_activo,codigo_empresa,vcuenta)
	bus = TRUE
	// Buscar fila
	IF dw_listado.RowCOunt() = 0 Then
		bus = FALSE
	ELSE
		j = dw_listado.find("codigo_cuenta = '"+vcuenta+"'",1,dw_listado.RowCOunt()) 
		IF j = 0 Then bus = FALSE
	END IF
	
	// Si no esta la fila a esa cuenta inserto
		IF NOt bus Then j = dw_listado.InsertRow(0)
		dw_listado.Object.codigo_cuenta[j] = vcuenta
		dw_listado.Object.cuenta[j]        = vtitulo
		IF vcuenta = "Z1" Then
			dw_listado.Object.cuenta[j] ="TOTAL KILOS"
			dw_listado.SetItem(j,"cal","2")
		ELSE
			dw_listado.SetItem(j,"cal","1")
		END IF
		f_valores(j)
		
  Next
  
  dw_listado.SetSort("codigo_empresa")
  dw_listado.Sort()
  //------------------------------------------------------------------
  //-------   Fin Componer lineas de cuentas -------------------------
  //------------------------------------------------------------------
  //------------------------------------------------------------------
    
  
  ante_coste = ""
  j2 = 0
  f_mascara()
  For xx = 1 To dw.Rowcount()
	vcoste = dw.GetItemString(xx,1)
	vcuenta = dw.GetItemString(xx,2)
	vimporte = dw.GetItemNumber(xx,3)
	vtitulo = f_nombre_contaplan(ejercicio_activo,codigo_empresa,vcuenta)
	vnombre = f_nombre_costesplan_abr(ejercicio_activo,codigo_empresa,vcoste)
	vn = vnombre
	bus = TRUE
	// Buscar fila
	IF dw_listado.RowCOunt() = 0 Then
		bus = FALSE
	ELSE
		j = dw_listado.find("codigo_cuenta = '"+vcuenta+"'",1,dw_listado.RowCOunt()) 
		IF j = 0 Then bus = FALSE
	END IF
	
	// Si no esta la fila a esa cuenta inserto
		IF NOt bus Then 
			j = dw_listado.InsertRow(0)
			total[j] = 0 
		END IF
		//---------------------------------------------------------------------------------
		// Suma Totales--------------------------------------------------------------------
		//---------------------------------------------------------------------------------
			iF IsNUll(total[j]) Then total[j] = 0 
			total[j] = total[j] + vimporte
		//---------------------------------------------------------------------------------
		
		dw_listado.Object.cuenta[j] = vtitulo
		dw_listado.Object.codigo_cuenta[j] = vcuenta
		IF vcuenta = "Z1" Then
			dw_listado.Object.cuenta[j] ="TOTAL KILOS"
			dw_listado.SetItem(j,"cal","2")
		ELSE
			dw_listado.SetItem(j,"cal","1")
		END IF
		IF ante_coste <> vcoste Then
		
			//Saldo de hoja
			IF j2 = 8 Then
				f_eti()
				dw_listado.GroupCalc()
				dw_listado.print(TRUE)
				hoja = hoja +1
				j2 = 0
				f_limpiar()
			END IF
			j2= j2 +1
		END IF
		f_valores(j)
		dw_listado.SetItem(1,Trim("fila"+STring(j2,"##")),vnombre)
		dw_listado.SetItem(1,Trim("codigo_fila"+STring(j2,"##")),vcoste)
		dw_listado.SetItem(j,Trim("importe"+STring(j2,"##")),vimporte)
		

		
		ante_coste = vcoste
  Next
  ultima = j2
  
 f_mascara_columna(dw_listado,Trim("importe"+STring(ultima +1,"##")),f_mascara_decimales(2))  

IF j2 = 8 Then
				f_eti()
				dw_listado.GroupCalc()
				dw_listado.print(TRUE)
				hoja = hoja +1
				f2 = 0
				f_limpiar()
END IF
// Totales
  For j = 1 To dw_listado.RowCount()
		suma = 0
		For h= 1 To ultima 
			dw_listado.SetItem(j,"hoja",hoja)
			dw_listado.SetItem(j,Trim("fila"+STring(h,"##")),dw_listado.GetItemSTring(1,"fila"+STring(h,"##")))
			dw_listado.SetItem(j,Trim("codigo_fila"+STring(h,"##")),dw_listado.GetItemSTring(1,"codigo_fila"+STring(h,"##")))
			dw_listado.SetItem(j,Trim("fila"+STring(ultima +1,"##")),"Total")
			Next
		dw_listado.SetItem(j,"importe"+STring(ultima +1,"##"),total[j])
  Next
  For v = ultima +2 To 8
		// invisible
		dw_listado.Modify("fila"+STring(v,"##") + ".Visible=0")
		dw_listado.Modify("importe"+STring(v,"##") + ".Visible=0")
		dw_listado.Modify("t"+STring(v,"##") + ".Visible=0")
		dw_listado.Modify("fila"+STring(v,"##") + ".x=5")
		dw_listado.Modify("importe"+STring(v,"##") + ".x=5")
		dw_listado.Modify("t"+STring(v,"##") + ".x=5")
	Next
	
	
				f_eti()  
				dw_listado.GroupCalc()
				dw_listado.print(TRUE)


  

destroy dw
end event

type cb_grabar from u_boton within w_con_cuadro_analitica_volcado
integer x = 1920
integer y = 128
integer width = 384
integer height = 92
integer taborder = 0
string facename = "Arial"
string text = "&Grabar"
end type

event clicked;Dec nu
IF mod = "N" Then Return

String cuenta,coste,codigo
Dec    importe,j1,j2

dw_1.AcceptText()
codigo = uo_bal.em_codigo.text

For j1 = 1 To 70
	coste = ""
	coste   = dw_1.GetItemString(1,Trim("codigo_fila"+STring(j1,"##")))
	iF Trim(coste) <> "" and  Not IsnUll(coste) Then
		For j2 = 1 To dw_1.RowCount()
			cuenta  =   dw_1.Object.codigo_cuenta[j2]
			importe =   dw_1.GetItemNumber(j2,Trim("importe"+STring(j1,"##")))
			
			Select count(*) Into :nu From  costesapuman 
			WHERE  costesapuman.codigo    = :codigo 
			AND    costesapuman.empresa   = :codigo_empresa
			AND    costesapuman.coste     = :coste
			AND    costesapuman.cuenta    = :cuenta;
			iF IsNull(nu) Then nu = 0
			iF nu = 0 Then
				iF importe <> 0 Then
				  INSERT INTO costesapuman (codigo,empresa,coste,importe,cuenta)  
				  VALUES (:codigo,:codigo_empresa,:coste,:importe,:cuenta);
				END IF
			ELSE
					//---------------------------
					// SI existe modifico
					//--------------------------
					UPDATE costesapuman 
					SET    importe = :importe  
					WHERE  costesapuman.codigo    = :codigo 
					AND    costesapuman.empresa   = :codigo_empresa
					AND    costesapuman.coste     = :coste
					AND    costesapuman.cuenta    = :cuenta;
					COMMIT;
			END IF
		Next
	END IF
Next
end event

type uo_1 from u_selec_impresoras within w_con_cuadro_analitica_volcado
event destroy ( )
integer x = 1495
integer y = 220
integer height = 108
integer taborder = 60
end type

on uo_1.destroy
call u_selec_impresoras::destroy
end on

event ue_valores;call super::ue_valores;u_selec_impresoras_report = dw_listado
end event

type st_cuenta from statictext within w_con_cuadro_analitica_volcado
integer x = 41
integer y = 1664
integer width = 2386
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Cuenta "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_cuenta from u_em_campo_2 within w_con_cuadro_analitica_volcado
event destroy ( )
integer x = 41
integer y = 1740
integer width = 2391
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cuenta.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cuenta.em_campo.text=f_nombre_contaplan(ejercicio_activo,codigo_empresa,uo_cuenta.em_codigo.text)
If Trim(uo_cuenta.em_campo.text)="" then
	uo_cuenta.em_campo.text=""
	uo_cuenta.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_contaplan_directo"
ue_titulo      = "AYUDA SELECCION DE CUENTAS CONTABLES"
ue_filtro      =""
end event

type cb_cuenta from commandbutton within w_con_cuadro_analitica_volcado
integer x = 2432
integer y = 1668
integer width = 453
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Añadir"
end type

event clicked;Dec j,h
j = dw_1.find("codigo_cuenta = '"+uo_cuenta.em_codigo.text+"'",1,dw_1.RowCOunt()) 
IF j = 0 Then 
	   j = dw_1.InsertRow(0)
		For h = 1 To ultima
			dw_1.SetItem(j,Trim("fila"+STring(h,"##")),dw_1.GetItemSTring(1,"fila"+STring(h,"##")))
			dw_1.SetItem(j,Trim("codigo_fila"+STring(h,"##")),dw_1.GetItemSTring(1,"codigo_fila"+STring(h,"##")))
		Next
		dw_1.SetItem(j,Trim("fila"+STring(ultima +1,"##")),"Total")
		dw_1.Object.cuenta[j] = uo_cuenta.em_campo.text
		dw_1.SetItem(j,"cal","1")
		dw_1.Object.codigo_cuenta[j] = uo_cuenta.em_codigo.text
		dw_1.SetItem(j,"mod",mod)
		dw_1.SetSort("cal,codigo_cuenta")
      dw_1.Sort()
END IF
end event

type cb_cuenta2 from commandbutton within w_con_cuadro_analitica_volcado
integer x = 2432
integer y = 1760
integer width = 453
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Borrar"
end type

event clicked;String vcuenta,vcodigo
Dec j

vcuenta = uo_cuenta.em_codigo.text 
vcodigo = uo_bal.em_codigo.text


Delete  from  costesapuman
Where   empresa   = :codigo_empresa
And     codigo    = :vcodigo
And     cuenta    = :vcuenta;
COMMIT;

j = dw_1.find("codigo_cuenta = '"+uo_cuenta.em_codigo.text+"'",1,dw_1.RowCOunt())

dw_1.DeleteRow(j)

end event

type pb_33 from picturebutton within w_con_cuadro_analitica_volcado
integer x = 2304
integer y = 128
integer width = 585
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Selección de Costes"
alignment htextalign = left!
end type

event clicked;dw_fam.visible=not dw_fam.visible
end event

type dw_fam from datawindow within w_con_cuadro_analitica_volcado
boolean visible = false
integer x = 32
integer y = 324
integer width = 1463
integer height = 928
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_selecc_cosval"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;if isnull(dwo) then return
if isnull(dwo.name) then return

long i

choose case dwo.name
	case "marcar"
		for i=1 TO rowcount()
			setitem(i,"marca","S")
		next
	case "desmarcar"
		for i=1 TO rowcount()
			setitem(i,"marca","N")
		next
			
end choose
end event

