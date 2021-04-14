$PBExportHeader$wi_con_form_simil.srw
forward
global type wi_con_form_simil from w_int_con_empresa
end type
type pb_1 from upb_salir within wi_con_form_simil
end type
type dw_1 from datawindow within wi_con_form_simil
end type
type dw_listado from datawindow within wi_con_form_simil
end type
type cb_1 from commandbutton within wi_con_form_simil
end type
type uo_formula from u_em_campo_2 within wi_con_form_simil
end type
type gb_5 from groupbox within wi_con_form_simil
end type
type gb_3 from groupbox within wi_con_form_simil
end type
type gb_2 from groupbox within wi_con_form_simil
end type
type gb_1 from groupbox within wi_con_form_simil
end type
type dw_2 from datawindow within wi_con_form_simil
end type
type gb_4 from groupbox within wi_con_form_simil
end type
end forward

global type wi_con_form_simil from w_int_con_empresa
integer width = 3081
integer height = 1716
pb_1 pb_1
dw_1 dw_1
dw_listado dw_listado
cb_1 cb_1
uo_formula uo_formula
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
gb_4 gb_4
end type
global wi_con_form_simil wi_con_form_simil

forward prototypes
public subroutine f_procesar (datawindow data)
end prototypes

public subroutine f_procesar (datawindow data);//datastore articulos
//datastore formulas
//string seleccion1,seleccion2,seleccion3
//long indice1,indice2,indice3
//long total1,total2,total3
//string articulo,familia,formato,calidad,formula
//real cantidad,cant_formula
//datetime fecha,fmin	
//long donde
//
//data.Reset()
//data.SetRedraw(FALSE)
//if data = dw_listado then
//	data.retrieve (codigo_empresa,STring(Date(em_fechadesde.text)),STring(Date(em_fechahasta.text)))
//else
//	data.retrieve (codigo_empresa)
//end if
//seleccion1 ="select articulo,familia,formato,cantidad,fecha from proddiaria "+&
//				"where empresa = '"+codigo_empresa+"' and "+&
//				"fecha between '"+STring(Date(em_fechadesde.text),"mm/dd/yy")+"' and '"+STring(Date(em_fechahasta.text),"mm/dd/yy")+"'"+&
//				" order by fecha,articulo,familia,formato"
//	
//articulos = f_cargar_cursor(seleccion1)
//
//total1 = articulos.rowcount()
//	
//if total1 > 0 then
//	for indice1 = 1 to total1
//		articulo = articulos.getitemstring(indice1,"articulo")
//		familia = articulos.getitemstring(indice1,"familia")
//		formato = articulos.getitemstring(indice1,"formato")
//		cantidad = articulos.getitemdecimal(indice1,"cantidad")
//		fecha = articulos.getitemdatetime(indice1,"fecha")
//		seleccion2 ="select formulacion,gramaje from proddetartic "+&
//						"where empresa = '"+codigo_empresa+"' and "+&
//						"articulo = '"+articulo+"'"
//		
//		formulas = f_cargar_cursor (seleccion2)
//		total2 = formulas.rowcount()
//		if total2 > 0 then
//			for indice2 = 1 to total2
//				formula = formulas.getitemstring(indice2,"formulacion")
//				cant_formula = formulas.getitemdecimal(indice2,"gramaje")
//				donde = data.insertrow(0)
//				data.setitem(donde,"empresa",codigo_empresa)
//				data.setitem(donde,"articulo",articulo)
//				data.setitem(donde,"familia",familia)
//				data.setitem(donde,"formato",formato)
//				data.setitem(donde,"formula",formula)
//				data.setitem(donde,"cant_dia",(cant_formula * cantidad)/1000)
//				data.setitem(donde,"dia",fecha)
//			next
//		end if
//   next
//end if
//data.SetRedraw(TRUE)
//data.Sort()
//data.GroupCalc()
//
//
//
end subroutine

on wi_con_form_simil.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.uo_formula=create uo_formula
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_formula
this.Control[iCurrent+6]=this.gb_5
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.gb_4
end on

on wi_con_form_simil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.uo_formula)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.gb_4)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Formulas Similares"
//istr_parametros.s_listado        =   "report_formatos_familias"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

IF istr_parametros.i_nargumentos>1 THEN	
	uo_formula.em_codigo.text = istr_parametros.s_argumentos[2]
   IF Trim(uo_formula.em_codigo.text)<>"" and Not IsNull(uo_formula.em_codigo.text) Then
	   uo_formula.em_campo.text = f_nombre_formulacion_laboratorio(codigo_empresa,uo_formula.em_codigo.text)
		if IsNull(uo_formula.em_campo.text) or Trim(uo_formula.em_campo.text) = "" then
			uo_formula.em_campo.text = ""
			uo_formula.em_codigo.text = ""
			f_activar_campo(uo_formula.em_campo)
		else
			dw_1.retrieve(codigo_empresa,uo_formula.em_codigo.text)
			dw_1.setfocus()
		end if	
   END IF
else
	f_activar_campo(uo_formula.em_campo)
END IF
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;//
//if trim(em_fechadesde.text)<>"" then
//	if trim(em_fechahasta.text)<>"" then
//			//dw_listado.retrieve(codigo_empresa,date(em_fechadesde.text),date(em_fechahasta.text))
//			f_procesar(dw_listado)
//			dw_report = dw_listado
//			Call Super::ue_listar
//	else
//		messagebox ("Error","Debe introducir el valor de la fecha tope")
//		setfocus(em_fechahasta)
//	end if
//else
//	messagebox ("Error","Debe introducir el valor de la fecha inicio")
//	setfocus(em_fechadesde)
//end if
//
end event

event ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_con_form_simil
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_con_form_simil
integer x = 1746
integer y = 864
integer width = 352
integer height = 312
fontcharset fontcharset = ansi!
end type

event getfocus;//f_activar_campo(uo_1.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within wi_con_form_simil
integer width = 837
end type

type pb_1 from upb_salir within wi_con_form_simil
integer x = 2871
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type dw_1 from datawindow within wi_con_form_simil
integer x = 9
integer y = 348
integer width = 1262
integer height = 1084
boolean bringtotop = true
string dataobject = "dw_proddetalleformulas_simil"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;long indice,total
int marcados
string columna

columna = this.GetColumnName( )

if columna = "x" then
	if data = "X" then
		this.accepttext()
		marcados = 0
		total = this.rowcount()
		for indice = 1 to total
			if this.getitemstring(indice,"x") = "X" then
				marcados = marcados + 1
			end if
		next
		if marcados = 3 then
			messagebox ("Atención","Unicamente puede marcar 3 casillas")
			data = "O"
			this.setitem(row,"x","O")
		end if
	end if
end if
end event

event itemchanged;long indice,total
int marcados
string columna

columna = this.GetColumnName( )

if columna = "x" then
	if data = "X" then
		this.accepttext()
		marcados = 0
		total = this.rowcount()
		for indice = 1 to total
			if this.getitemstring(indice,"x") = "X" then
				marcados = marcados + 1
			end if
		next
		if marcados = 3 then
			messagebox ("Atención","Unicamente puede marcar 3 casillas")
			data = "O"
			this.setitem(row,"x","O")
		end if
	end if
end if
end event

type dw_listado from datawindow within wi_con_form_simil
boolean visible = false
integer y = 4
integer width = 329
integer height = 160
boolean bringtotop = true
string dataobject = "report_con_cant_articulos_form"
boolean livescroll = true
end type

type cb_1 from commandbutton within wi_con_form_simil
integer x = 859
integer y = 236
integer width = 402
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;string articulos[3]
dec{2} cantidades[3]
string articulo_ant
dec{2} cantidad_ant
long indice,total,indmatr,i
str_resultado_form_simil resultado
dw_2.reset()
for i = 1 to 3
	articulos[i] = ""
	cantidades[i]= 0
next
indmatr = 1
total = dw_1.rowcount()
indice = 1
if total > 0 then	
	do
		if dw_1.getitemstring(indice,"x") = "X" then	
			articulos[indmatr]  = dw_1.getitemstring(indice,"mp")
			cantidades[indmatr] = dw_1.getitemnumber(indice,"v_cantidad")
			indmatr = indmatr + 1
		end if
		indice = indice + 1
	loop until indmatr > 3 or indice > total
	
	if indmatr > 1 then
		if indmatr <= 3 then
			articulo_ant = articulos[indmatr - 1]
			cantidad_ant = cantidades[indmatr - 1]
			for indice = indmatr + 1 to 3
				articulos[indice]  = articulo_ant
				cantidades[indice] = cantidad_ant		
			next
		end if
		
		resultado = f_formulas_similares(codigo_empresa,articulos[1],cantidades[1],articulos[2],cantidades[2],articulos[3],cantidades[3])
		for indice = 1 to 1000
			if resultado.kk[indice] = uo_formula.em_codigo.text then
				resultado.kk[indice] = ""
			end if
		next
		dw_2.retrieve(codigo_empresa,resultado.kk)
	end if
	dw_1.setfocus()
end if
end event

type uo_formula from u_em_campo_2 within wi_con_form_simil
event destroy ( )
integer x = 91
integer y = 220
integer width = 736
integer taborder = 70
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formula.destroy
call u_em_campo_2::destroy
end on

event modificado;
//uo_formula.em_campo.text = f_nombre_formulacion_laboratorio(codigo_empresa,uo_formula.em_codigo.text)
//
//if IsNull(uo_formula.em_campo.text) or Trim(uo_formula.em_campo.text) = "" then
//	uo_formula.em_campo.text = ""
//	uo_formula.em_codigo.text = ""
//	f_activar_campo(uo_formula.em_campo)
//else
//	dw_1.retrieve(codigo_empresa,uo_formula.em_codigo.text)
//	dw_1.setfocus()
//end if
	
	
	
uo_formula.em_campo.text = f_nombre_formulacion_laboratorio(codigo_empresa,uo_formula.em_codigo.text)

IF Trim(uo_formula.em_campo.text) = "" THEN 
 	IF Trim(uo_formula.em_codigo.text) <> "" Then
		dw_1.retrieve(codigo_empresa,uo_formula.em_codigo.text)
		dw_1.setfocus()
	END IF
 	uo_formula.em_campo.text  = ""
 	uo_formula.em_codigo.text = ""
END IF


end event

event getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodformulaciones"
ue_titulo      = "AYUDA SELECCION DE FORMULACIONES"
ue_filtro      =""

end event

type gb_5 from groupbox within wi_con_form_simil
integer x = 9
integer y = 144
integer width = 69
integer height = 196
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within wi_con_form_simil
integer x = 846
integer y = 144
integer width = 430
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
end type

type gb_2 from groupbox within wi_con_form_simil
integer x = 1280
integer y = 144
integer width = 1691
integer height = 124
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
end type

type gb_1 from groupbox within wi_con_form_simil
integer x = 78
integer y = 144
integer width = 763
integer height = 196
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Formula"
end type

type dw_2 from datawindow within wi_con_form_simil
integer x = 1280
integer y = 272
integer width = 1696
integer height = 1160
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_resul_formulas_simil"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within wi_con_form_simil
integer x = 846
integer y = 196
integer width = 430
integer height = 144
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
end type

