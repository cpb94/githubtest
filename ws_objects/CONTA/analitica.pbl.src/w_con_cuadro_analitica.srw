$PBExportHeader$w_con_cuadro_analitica.srw
$PBExportComments$€
forward
global type w_con_cuadro_analitica from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_cuadro_analitica
end type
type em_fechadesde from u_em_campo within w_con_cuadro_analitica
end type
type gb_1 from groupbox within w_con_cuadro_analitica
end type
type cb_consulta from u_boton within w_con_cuadro_analitica
end type
type em_fechahasta from u_em_campo within w_con_cuadro_analitica
end type
type st_1 from statictext within w_con_cuadro_analitica
end type
type pb_imprimir_preli from picturebutton within w_con_cuadro_analitica
end type
type em_nivel from editmask within w_con_cuadro_analitica
end type
type st_2 from statictext within w_con_cuadro_analitica
end type
type em_nivel_coste from editmask within w_con_cuadro_analitica
end type
type st_3 from statictext within w_con_cuadro_analitica
end type
type dw_listado from datawindow within w_con_cuadro_analitica
end type
type dw_1 from datawindow within w_con_cuadro_analitica
end type
end forward

global type w_con_cuadro_analitica from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2917
integer height = 2248
string title = "Consulta de Movimientos"
pb_2 pb_2
em_fechadesde em_fechadesde
gb_1 gb_1
cb_consulta cb_consulta
em_fechahasta em_fechahasta
st_1 st_1
pb_imprimir_preli pb_imprimir_preli
em_nivel em_nivel
st_2 st_2
em_nivel_coste em_nivel_coste
st_3 st_3
dw_listado dw_listado
dw_1 dw_1
end type
global w_con_cuadro_analitica w_con_cuadro_analitica

type variables
Dec hoja
String vn
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_limpiar ()
public subroutine f_mascara ()
public subroutine f_valores (integer j)
public subroutine f_eti ()
end prototypes

public subroutine f_cargar (datawindow dw_data);Dec       nivel,digitos,ejer,dig[],digotos_cta,vimporte,j,xx,j2,h,ultima,v,suma
Boolean bus
DateTime  fechad,fechah
STring vcoste,vcuenta,vnombre,vtitulo,ante_coste



dw_data.SetRedraw(FALSE)

SetPointer(HourGlass!)

dw_data.Reset()

nivel = Dec(em_nivel.text)

IF Dec(em_nivel_coste.text) = 1 Then
	digitos  = f_digitos_analitica_primer_nivel()
ELSE
	digitos  = f_digitos_analitica_segundo_nivel()
END IF

fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))

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
  " SELECT SubString(costesapu.coste,1,"  + STring(digitos,"###############")+") cost ,       "  +&
  "        SubString(costesapu.cuenta,1," + String(digotos_cta,"##############") + ") cta,    "  +&
  "        Sum(debe-haber) imp,contaplan.titulo,costesplan.resumido  "  +&
  " FROM costesapu,contaplan,costesplan                          "  +&
  " WHERE ( costesapu.ejercicio = contaplan.ejercicio ) and      "  +&
  "       ( costesapu.empresa = contaplan.empresa ) and          "  +&
  "       ( SubString(costesapu.cuenta,1," + String(digotos_cta,"##############") + ") = contaplan.cuenta ) and  "  +&
  "       ( costesapu.ejercicio = costesplan.ejercicio ) and        "  +&
  "       ( costesapu.empresa   = costesplan.empresa ) and            "  +&
  "       ( SubString(costesapu.coste,1," + String(digitos,"##############")    + ") = costesplan.coste ) and  "  +&
  "       ( ( costesapu.empresa = '"       + codigo_empresa   + "' ) AND            "  +&
  "       ( costesapu.fapunte between '"   + String(fechad,"dd/mm/yyyy") + "'  AND  '"+String(fechah,"dd/mm/yyyy")+"' ) )     "  +&
  "   GROUP BY SubString(costesapu.coste,1," + String(digitos,"##############") + "),costesplan.resumido,"  +&
  "   SubString(costesapu.cuenta,1,"       + String(digotos_cta,"#############")+"),contaplan.titulo  "  +&
  " ORDER BY SubString(costesapu.coste,1," + String(digitos)+") ASC,      "  +&
  "          SubString(costesapu.cuenta,1,"+ String(digotos_cta,"#############")+") ASC  "   

//  dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
  ante_coste = ""
  j2 = 0
  For xx = 1 To dw.Rowcount()
	vcoste = dw.GetItemString(xx,1)
	vcuenta = dw.GetItemString(xx,2)
	vimporte = dw.GetItemNumber(xx,3)
	vtitulo = dw.Object.contaplan_titulo[xx]
	vnombre = dw.Object.costesplan_resumido[xx]
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
		dw_data.Object.codigo_cuenta[j] = vcuenta
		IF ante_coste <> vcoste Then
			j2 ++
		END IF
		dw_data.SetItem(1,Trim("fila"+STring(j2,"##")),vnombre)
		dw_data.SetItem(1,Trim("codigo_fila"+STring(j2,"##")),vcoste)
		dw_data.SetItem(j,Trim("importe"+STring(j2,"##")),vimporte)
		ante_coste = vcoste
  Next
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
				f_mascara_columna(dw_data,Trim("importe"+STring(h,"##")),f_mascara_decimales(2))
				f_mascara_columna(dw_data,Trim("t"+STring(h,"##")),f_mascara_decimales(2))
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
  
  dw_data.SetSort("codigo_cuenta")
  dw_data.Sort()
  dw_data.SetRedraw(TRUE)
  
  SetPointer(Arrow!)

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

f1 = DAteTime(Date(em_fechadesde.text))
f2 = DAteTime(Date(em_fechahasta.text))

dw_listado.SetItem(j,"hoja",hoja)
dw_listado.SetItem(j,"empresa",codigo_empresa)
dw_listado.SetItem(j,"f1",f1)
dw_listado.SetItem(j,"f2",f2)
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

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;This.title = " CUADRO DE ANALITICA"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(RelativeDate(MDY(01,01,Year(Today())+1),-1))

dw_1.visible = False





end event

on w_con_cuadro_analitica.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.em_fechadesde=create em_fechadesde
this.gb_1=create gb_1
this.cb_consulta=create cb_consulta
this.em_fechahasta=create em_fechahasta
this.st_1=create st_1
this.pb_imprimir_preli=create pb_imprimir_preli
this.em_nivel=create em_nivel
this.st_2=create st_2
this.em_nivel_coste=create em_nivel_coste
this.st_3=create st_3
this.dw_listado=create dw_listado
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.em_fechadesde
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_consulta
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.pb_imprimir_preli
this.Control[iCurrent+8]=this.em_nivel
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_nivel_coste
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.dw_1
end on

on w_con_cuadro_analitica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.em_fechadesde)
destroy(this.gb_1)
destroy(this.cb_consulta)
destroy(this.em_fechahasta)
destroy(this.st_1)
destroy(this.pb_imprimir_preli)
destroy(this.em_nivel)
destroy(this.st_2)
destroy(this.em_nivel_coste)
destroy(this.st_3)
destroy(this.dw_listado)
destroy(this.dw_1)
end on

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_cuadro_analitica
integer x = 489
integer y = 636
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_cuadro_analitica
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_cuadro_analitica
integer y = 20
integer width = 2642
end type

type pb_2 from upb_salir within w_con_cuadro_analitica
integer x = 2725
integer y = 16
integer width = 128
integer height = 112
integer taborder = 0
end type

type em_fechadesde from u_em_campo within w_con_cuadro_analitica
integer x = 41
integer y = 196
integer width = 279
integer taborder = 10
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_1.RESET()
end event

type gb_1 from groupbox within w_con_cuadro_analitica
integer x = 5
integer y = 124
integer width = 658
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha Apunte"
end type

type cb_consulta from u_boton within w_con_cuadro_analitica
integer x = 722
integer y = 176
integer width = 306
integer height = 92
integer taborder = 30
boolean bringtotop = true
string facename = "Arial"
string text = "C&onsulta"
end type

event clicked;f_cargar(dw_1)
dw_1.visible   = TRUE

end event

type em_fechahasta from u_em_campo within w_con_cuadro_analitica
integer x = 361
integer y = 196
integer width = 279
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;dw_1.RESET()
end event

type st_1 from statictext within w_con_cuadro_analitica
integer x = 320
integer y = 176
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -11
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

type pb_imprimir_preli from picturebutton within w_con_cuadro_analitica
integer x = 1029
integer y = 176
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


Dec       nivel,digitos,ejer,dig[],digotos_cta,vimporte,j,xx,j2,h,ultima,v,suma,f2
Boolean bus
DateTime  fechad,fechah
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

fechad=Datetime(Date(String(em_fechadesde.Text)))
fechah=Datetime(Date(String(em_fechahasta.Text)))
ejer=year(date(fechad))

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
  " SELECT SubString(costesapu.coste,1,"  + STring(digitos,"###########")+") cost ,       "  +&
  "        SubString(costesapu.cuenta,1," + String(digotos_cta,"###########") + ") cta,    "  +&
  "        Sum(debe-haber) imp,contaplan.titulo,costesplan.resumido  "  +&
  " FROM costesapu,contaplan,costesplan                          "  +&
  " WHERE ( costesapu.ejercicio = contaplan.ejercicio ) and      "  +&
  "       ( costesapu.empresa = contaplan.empresa ) and          "  +&
  "       ( SubString(costesapu.cuenta,1," + String(digotos_cta,"###########") + ") = contaplan.cuenta ) and  "  +&
  "       ( costesapu.ejercicio = costesplan.ejercicio ) and        "  +&
  "       ( costesapu.empresa   = costesplan.empresa ) and            "  +&
  "       ( SubString(costesapu.coste,1," + String(digitos,"###########")    + ") = costesplan.coste ) and  "  +&
  "       ( ( costesapu.empresa = '"       + codigo_empresa   + "' ) AND            "  +&
  "       ( costesapu.fapunte between '"   + String(fechad,"dd/mm/yyyy") + "'  AND  '"+String(fechah,"dd/mm/yyyy")+"' ) )     "  +&
  "   GROUP BY SubString(costesapu.coste,1," + String(digitos,"###########") + "),costesplan.resumido,"  +&
  "   SubString(costesapu.cuenta,1,"       + String(digotos_cta,"###########")+"),contaplan.titulo  "  +&
  " ORDER BY SubString(costesapu.coste,1," + String(digitos)+") ASC,      "  +&
  "          SubString(costesapu.cuenta,1,"+ String(digotos_cta,"###########")+") ASC  "   

//  dw = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, dw)
  //------------------------------------------------------------------
  // Componer lineas de cuentas
  //------------------------------------------------------------------
  
  For xx = 1 To dw.Rowcount()
	vcuenta = dw.GetItemString(xx,2)
	vtitulo = dw.Object.contaplan_titulo[xx]
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
		f_valores(j)
		
  Next
  dw_listado.SetSort('codigo_cuenta')
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
	vtitulo = dw.Object.contaplan_titulo[xx]
	vnombre = dw.Object.costesplan_resumido[xx]
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
		dw_listado.Object.cuenta[j] = vtitulo
		dw_listado.Object.codigo_cuenta[j] = vcuenta
		IF ante_coste <> vcoste Then
		
			//Saldo de hoja
			IF j2 = 8 Then
				f_eti()
				dw_listado.Groupcalc()
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
		dw_listado.SetItem(j,"cal","1")
		iF j <> 0 Then
		iF IsNUll(total[j]) Then total[j] = 0 
			total[j] = total[j] + vimporte
		END IF
		ante_coste = vcoste
  Next
  ultima = j2
  
 f_mascara_columna(dw_listado,Trim("importe"+STring(ultima +1,"##")),f_mascara_decimales(2))  

IF j2 = 8 Then
				f_eti()
				dw_listado.Groupcalc()
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
dw_listado.Groupcalc()
dw_listado.print(TRUE)

destroy dw


  



end event

type em_nivel from editmask within w_con_cuadro_analitica
integer x = 1714
integer y = 172
integer width = 224
integer height = 84
integer taborder = 40
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
end type

type st_2 from statictext within w_con_cuadro_analitica
integer x = 1230
integer y = 184
integer width = 457
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Nivel Contable:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_nivel_coste from editmask within w_con_cuadro_analitica
integer x = 2382
integer y = 172
integer width = 224
integer height = 84
integer taborder = 10
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

type st_3 from statictext within w_con_cuadro_analitica
integer x = 1989
integer y = 184
integer width = 393
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Nivel Coste:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_cuadro_analitica
boolean visible = false
integer x = 27
integer y = 320
integer width = 2761
integer height = 1076
string dataobject = "report_con_cuadro_analitica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_cuadro_analitica
integer x = 32
integer y = 320
integer width = 2825
integer height = 1728
string dataobject = "dw_con_cuadro_analitica"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

