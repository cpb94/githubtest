$PBExportHeader$w_impresoras_v4.srw
$PBExportComments$Rutina de impresion, recibe la datawindow con datos para imprimir el retrieve lo tiene el programa que lanza el listado.
forward
global type w_impresoras_v4 from window
end type
type cbx_ajustar_documento_a_papel from checkbox within w_impresoras_v4
end type
type phl_1 from picturehyperlink within w_impresoras_v4
end type
type cbx_pdf from checkbox within w_impresoras_v4
end type
type uo_impresoras from u_selec_impresoras within w_impresoras_v4
end type
type cb_preliminar from u_boton within w_impresoras_v4
end type
type em_paginas from editmask within w_impresoras_v4
end type
type st_8 from statictext within w_impresoras_v4
end type
type cb_aceptar from u_aceptar within w_impresoras_v4
end type
type cb_cancelar from u_cancelar within w_impresoras_v4
end type
type mle_1 from multilineedit within w_impresoras_v4
end type
type ddlb_rango from dropdownlistbox within w_impresoras_v4
end type
type st_4 from statictext within w_impresoras_v4
end type
type cbx_imprime_a_fichero from checkbox within w_impresoras_v4
end type
type sle_rango_paginas from singlelineedit within w_impresoras_v4
end type
type rb_paginas from radiobutton within w_impresoras_v4
end type
type rb_todas from radiobutton within w_impresoras_v4
end type
type em_copias from editmask within w_impresoras_v4
end type
type st_2 from statictext within w_impresoras_v4
end type
type gb_1 from groupbox within w_impresoras_v4
end type
type cb_excel from commandbutton within w_impresoras_v4
end type
end forward

global type w_impresoras_v4 from window
integer x = 256
integer y = 160
integer width = 2011
integer height = 972
boolean titlebar = true
string title = "Opciones de Impresión"
windowtype windowtype = response!
long backcolor = 12632256
cbx_ajustar_documento_a_papel cbx_ajustar_documento_a_papel
phl_1 phl_1
cbx_pdf cbx_pdf
uo_impresoras uo_impresoras
cb_preliminar cb_preliminar
em_paginas em_paginas
st_8 st_8
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
mle_1 mle_1
ddlb_rango ddlb_rango
st_4 st_4
cbx_imprime_a_fichero cbx_imprime_a_fichero
sle_rango_paginas sle_rango_paginas
rb_paginas rb_paginas
rb_todas rb_todas
em_copias em_copias
st_2 st_2
gb_1 gb_1
cb_excel cb_excel
end type
global w_impresoras_v4 w_impresoras_v4

type variables
string is_rango_paginas
datawindow  report

end variables

forward prototypes
private subroutine wf_rango_paginas (radiobutton arb_opcion)
public subroutine f_ajustar_documento_a_papel ()
end prototypes

private subroutine wf_rango_paginas (radiobutton arb_opcion);CHOOSE CASE arb_opcion

	CASE rb_todas
		sle_rango_paginas.text = ''
		is_rango_paginas = 'a'
	
	CASE rb_paginas	
		is_rango_paginas = 'p'

END CHOOSE
end subroutine

public subroutine f_ajustar_documento_a_papel ();String ls_objetos, ls_array_objetos[],ls_unidad_medida,ls_orientation
Long   ll_objeto,ll_numero_objetos,ll_zoom
dec    ld_maxx,ld_posx,ld_width,ld_x,ld_maxx_visible,ld_margen_derecho,ld_margen_izquierdo
n_dwr_string ln_dwr_string
 
ld_margen_izquierdo = dec(report.describe("datawindow.print.Margin.Left"))
ld_margen_derecho = dec(report.describe("datawindow.print.Margin.Right"))
 
ls_orientation   = report.describe("datawindow.print.orientation")
ls_unidad_medida = report.describe("DataWindow.Units")
 
ls_objetos = report.describe("DataWindow.Objects")
ll_numero_objetos = ln_dwr_string.of_ParseToArray(ls_objetos, '~t', ls_array_objetos[])
 
ld_maxx = 0
 
For ll_objeto = 1 to ll_numero_objetos
                if report.describe(ls_array_objetos[ll_objeto] + '.visible') = "1" then
                               ld_posx  = dec(report.describe(ls_array_objetos[ll_objeto] + '.x'))
                               ld_width = dec(report.describe(ls_array_objetos[ll_objeto] + '.width'))
                              
                               ld_x = ld_posx + ld_width
                              
                               if ld_maxx < ld_x then
                                               ld_maxx = ld_x
                               end if
                end if
Next
 
//0 — PowerBuilder units
//1 —Display pixels
//2 — 1/1000 of a logical inch
//3 — 1/1000 of a logical centimeter
 
choose case ls_unidad_medida
                case "0"
                               if ls_orientation = "1" then
                                               ld_maxx_visible = 5065
                               else
                                               ld_maxx_visible = 3374
                               end if
                case "1"
                               if ls_orientation = "1" then
                                               ld_maxx_visible = 1108
                               else
                                               ld_maxx_visible = 738
                               end if
                case "2"
                               if ls_orientation = "1" then
                                               ld_maxx_visible = 11.541
                               else
                                               ld_maxx_visible = 7.687
                               end if
                case "3"
                               if ls_orientation = "1" then
                                               ld_maxx_visible = 29315
                               else
                                               ld_maxx_visible = 19526
                               end if
end choose
 
ld_maxx_visible = ld_maxx_visible - (ld_margen_derecho + ld_margen_izquierdo)
 
if ld_maxx > ld_maxx_visible then
                if cbx_ajustar_documento_a_papel.checked then
                               ll_zoom = (ld_maxx_visible / ld_maxx) * 100
                else
                               ll_zoom = 100
                end if
               
                report.Object.DataWindow.Zoom = ll_zoom
 
end if
end subroutine

event open;string tipo_columna,setting
string v_impresora_predeterminada,v_usuario_impresora_predeterminada
dec    ld_zoom

report =  Message.PowerObjectParm

ld_zoom = dec(report.Object.DataWindow.Zoom)

if ld_zoom <> 100 then cbx_ajustar_documento_a_papel.checked = true

IF report.RowCount() <> 0 Then	
//	DataWindowChild dwc_cabecera
//
//	setting = report.Object.DataWindow.Nested
//	messagebox("",setting)
//	
//	importnestedreport
//	setting = report.Describe("DataWindow.Nested")
//
//	messagebox("",setting)
//	IF report.GetChild("empresa", dwc_cabecera) = 1 then		
//		dwc_cabecera.modify("imagen_cabecera_empresa.Filename = '"+f_imagen_cabecera_empresa(codigo_empresa)+"'")
//	else
//		IF report.GetChild("empresa", dwc_cabecera) = 1 then
//			dwc_cabecera.modify("imagen_cabecera_legal_empresa.Filename = '"+f_imagen_cabecera_legal_empresa(codigo_empresa)+"'")
//			//dwc_cabecera.Object.imagen_cabecera_legal_empresa.Filename = f_imagen_cabecera_legal_empresa(codigo_empresa)
//		else
//			messagebox("","")
//		end if		
//	end if
	
em_paginas.text = report.Describe("evaluate('pageCount()',0)")	
em_copias.text = report.describe('datawindow.print.copies')
//tipo_columna = report.Describe("total_paginas.Coltype")
//	
//if tipo_columna <> "!" then
//	em_paginas.text = String(report.GetItemNumber(1,"total_paginas"))
//else
//	em_paginas.text = "0"
//end if
	

//	em_paginas.text = report.Describe("evaluate('pagecount()',1)")

	
	
	
	
END IF

//if f_impresora_pdf() <> "" then
//	cbx_pdf.enabled = true
//else
//	cbx_pdf.enabled = false
//end if

//Gestion de impresora por defecto

select impresora
into   :v_impresora_predeterminada
from   ven_parametros_impresora
where  empresa = :codigo_empresa
and    usuario = :nombre_usuario
and    predeterminada_siempre = 'S'
and    impresora <> 'PREDETERMINADA';

if isnull(v_impresora_predeterminada) then v_impresora_predeterminada = ""

if trim(v_impresora_predeterminada) <> "" then
	if left(v_impresora_predeterminada,15) = "PREDETERMINADA " then
		v_usuario_impresora_predeterminada = right(v_impresora_predeterminada,len(v_impresora_predeterminada)-15)
		
		v_impresora_predeterminada = ""
		
		select impresora
		into   :v_impresora_predeterminada
		from   ven_parametros_impresora
		where  empresa = :codigo_empresa
		and    usuario = :v_usuario_impresora_predeterminada
		and    impresora like 'PRED_%'
		and    impresora <> 'PREDETERMINADA';
		
		if isnull(v_impresora_predeterminada) then v_impresora_predeterminada = ""
		
		if trim(v_impresora_predeterminada) <> "" then
			v_impresora_predeterminada = right(v_impresora_predeterminada,len(v_impresora_predeterminada)-5)				
		else
			v_impresora_predeterminada = ""
		end if								
	end if			
end if

if v_impresora_predeterminada <> "" then
	f_cambia_impresora_predeterminada(v_impresora_predeterminada)
end if

uo_impresoras.TriggerEvent(constructor!)
is_rango_paginas = 'a'




end event

on w_impresoras_v4.create
this.cbx_ajustar_documento_a_papel=create cbx_ajustar_documento_a_papel
this.phl_1=create phl_1
this.cbx_pdf=create cbx_pdf
this.uo_impresoras=create uo_impresoras
this.cb_preliminar=create cb_preliminar
this.em_paginas=create em_paginas
this.st_8=create st_8
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.mle_1=create mle_1
this.ddlb_rango=create ddlb_rango
this.st_4=create st_4
this.cbx_imprime_a_fichero=create cbx_imprime_a_fichero
this.sle_rango_paginas=create sle_rango_paginas
this.rb_paginas=create rb_paginas
this.rb_todas=create rb_todas
this.em_copias=create em_copias
this.st_2=create st_2
this.gb_1=create gb_1
this.cb_excel=create cb_excel
this.Control[]={this.cbx_ajustar_documento_a_papel,&
this.phl_1,&
this.cbx_pdf,&
this.uo_impresoras,&
this.cb_preliminar,&
this.em_paginas,&
this.st_8,&
this.cb_aceptar,&
this.cb_cancelar,&
this.mle_1,&
this.ddlb_rango,&
this.st_4,&
this.cbx_imprime_a_fichero,&
this.sle_rango_paginas,&
this.rb_paginas,&
this.rb_todas,&
this.em_copias,&
this.st_2,&
this.gb_1,&
this.cb_excel}
end on

on w_impresoras_v4.destroy
destroy(this.cbx_ajustar_documento_a_papel)
destroy(this.phl_1)
destroy(this.cbx_pdf)
destroy(this.uo_impresoras)
destroy(this.cb_preliminar)
destroy(this.em_paginas)
destroy(this.st_8)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.mle_1)
destroy(this.ddlb_rango)
destroy(this.st_4)
destroy(this.cbx_imprime_a_fichero)
destroy(this.sle_rango_paginas)
destroy(this.rb_paginas)
destroy(this.rb_todas)
destroy(this.em_copias)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.cb_excel)
end on

type cbx_ajustar_documento_a_papel from checkbox within w_impresoras_v4
integer x = 704
integer y = 208
integer width = 777
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ajustar documento a papel"
end type

type phl_1 from picturehyperlink within w_impresoras_v4
integer x = 1550
integer y = 588
integer width = 128
integer height = 112
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\GNOCERAMIC\RECURSOS\ENABLED\Doc-Excel.gif"
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;//report.saveas("c:\formato_web.html", htmltable!, true)
// 
//oleobject excel 
//
//excel = create oleobject 
//
//if excel.connecttonewobject("excel.application") = 0 then 
//	excel.application.displayalerts = false 
//	excel.application.workbooks.open("c:\formato_web.html")
//	excel.application.workbooks(1).parent.windows(excel.application.workbooks(1).name).visible = true 
//	
//	string ande, file
//	
//	if getfilesavename("Elija nombre y ubicacion", ande, file , "XLS", "Libros Excel (*.XLS),*.XLS") = 1 then	
//		excel.application.workbooks(1).saveas(ande, 39) 		
//	end if
//	excel.application.workbooks(1).close() 
//else
//	messagebox("ERROR", "")
//end if 
//
//excel.disconnectobject()
//
//destroy excel 
//string ande, file
//
//if getfilesavename("Elija nombre y ubicacion", ande, file , "XLS", "Libros Excel (*.XLS),*.XLS") = 1 then	
//	uf_save_dw_as_excel(report,ande) 		
//end if
//

Int					li_valor
String			ls_path, ls_file

//Open (w_excel_response)
//
//li_valor = Message.DoubleParm
//
//IF li_valor = 1 THEN
//	IF getfilesavename ( 'Archivos',ls_path,ls_file,'XLS','XLS Files (*.XLS), *.XLS') = 1 THEN 	
//		uf_save_dw_as_excel ( report, ls_file )	// Si es DataWindow	
////		uf_save_ds_as_excel ( dw_1, ls_file )	// Si es DataStore
//	END IF
//ELSEIF li_valor = 2 THEN
//	if getfilesavename ( 'Archivos',ls_path,ls_file,'XLS','XLS Files (*.XLS), *.XLS') = 1 THEN report.saveas(ls_file,Excel5!,TRUE)
//END IF

end event

type cbx_pdf from checkbox within w_impresoras_v4
integer x = 1138
integer y = 144
integer width = 224
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "PDF"
end type

type uo_impresoras from u_selec_impresoras within w_impresoras_v4
integer height = 100
end type

event ue_valores;call super::ue_valores;u_selec_impresoras_report = report
end event

on uo_impresoras.destroy
call u_selec_impresoras::destroy
end on

type cb_preliminar from u_boton within w_impresoras_v4
event clicked pbm_bnclicked
integer x = 1550
integer y = 712
integer height = 92
integer taborder = 60
string text = "&Preliminar"
end type

event clicked;call super::clicked;f_ajustar_documento_a_papel()
f_preliminar(report)
end event

type em_paginas from editmask within w_impresoras_v4
integer x = 1874
integer y = 28
integer width = 137
integer height = 88
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "1"
boolean border = false
string mask = "#####"
double increment = 1
string minmax = "1~~15"
end type

type st_8 from statictext within w_impresoras_v4
integer x = 1550
integer y = 24
integer width = 315
integer height = 68
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Páginas:"
boolean focusrectangle = false
end type

type cb_aceptar from u_aceptar within w_impresoras_v4
integer x = 1541
integer y = 212
integer height = 92
integer taborder = 100
string text = "&Aceptar"
end type

event clicked;string ls_tmp
string ls_comando
long ll_fila 
string	ls_nomdoc, ls_nom
int	li_valor,indice,bien
bien = 0


CHOOSE CASE lower(left(ddlb_rango.Text,1)) 
	CASE 't' 				// Todas las paginas
		ls_tmp = '0'
	CASE 'p'					// Las Pares
		ls_tmp = '1'
	CASE 'i' 				// Las Impares
		ls_tmp = '2'
END CHOOSE

ls_comando = 'datawindow.print.page.rangeinclude = ' + ls_tmp

CHOOSE CASE is_rango_paginas // Imprimir un rango de paginas
	CASE 'a'  				// Todas
		ls_tmp = ''
	CASE 'c' 				// Pagina actual

		ll_fila = report.GetRow()
		ls_tmp  = report.Describe("evaluate('page()',"+string(ll_fila)+")")

	CASE 'p' 				// Rango de paginas
		ls_tmp = sle_rango_paginas.text
END CHOOSE
	
IF len(ls_tmp) > 0 THEN
	ls_comando = ls_comando +  " datawindow.print.page.range = '"+ls_tmp+"'"
END IF

//	Numero de copias
IF len(em_copias.text) > 0 THEN
	ls_comando = ls_comando +  " datawindow.print.copies = 1"
END IF

		// Imprimir a un Fichero

IF cbx_imprime_a_fichero.checked THEN 
	report.saveas()	
	CLOSE(PARENT)
	RETURN
END IF

f_ajustar_documento_a_papel()

//IF cbx_pdf.checked THEN 
//	f_imprimir_documento_usuario("PDF",report)
//	return
//END IF
//// Imprimir a Fichero PDF
//
if cbx_pdf.checked then
		
	report.Object.DataWindow.Export.PDF.Method = Distill!	
	report.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
	report.Object.DataWindow.Printer = ""//f_impresora_pdf()
	
	report.SaveAs("c:\custom.pdf", PDF!, true)	
	
	CloseWithReturn(Parent,1)

else
	// Modificar la DataWindow

	ls_tmp = report.Modify(ls_comando)
	IF len(ls_tmp) > 0 THEN
		MessageBox('Error al preparar las Opciones de Impresión', &
						'Mensaje de Error = ' + ls_tmp + '~r~nls_comando = ' + ls_comando)
		Return
	END IF
	IF Dec(em_copias.text) <= 0 Then em_copias.text = "1"
	parent.enabled = false
	For indice = 1 to Dec(em_copias.text)
		IF report.Print(TRUE) <> 1 Then bien = 1
	Next
	parent.enabled = true
	IF bien = 0 Then
	  CloseWithReturn(Parent,1)
	ELSE
	  CloseWithReturn(Parent,-1)
	END IF
	
end if



end event

type cb_cancelar from u_cancelar within w_impresoras_v4
integer x = 1541
integer y = 332
integer height = 92
integer taborder = 110
string text = "&Salir"
boolean cancel = true
end type

on clicked;CloseWithReturn(Parent,-1)
end on

type mle_1 from multilineedit within w_impresoras_v4
integer x = 110
integer y = 516
integer width = 1207
integer height = 128
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Introducir numeros y/o rangos de pagina separados por comas. Por ejemplo, 2,5,8-10"
boolean border = false
end type

type ddlb_rango from dropdownlistbox within w_impresoras_v4
integer x = 320
integer y = 736
integer width = 1029
integer height = 288
integer taborder = 90
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Todas la Paginas del Rango"
boolean sorted = false
string item[] = {"Todas la Paginas del Rango","Impares","Pares"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_impresoras_v4
integer x = 46
integer y = 736
integer width = 233
integer height = 68
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "&Imprimir:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_imprime_a_fichero from checkbox within w_impresoras_v4
integer x = 704
integer y = 144
integer width = 357
integer height = 52
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "A &Fichero"
end type

type sle_rango_paginas from singlelineedit within w_impresoras_v4
integer x = 489
integer y = 420
integer width = 846
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

on getfocus;rb_paginas.TriggerEvent(clicked!)
end on

type rb_paginas from radiobutton within w_impresoras_v4
integer x = 142
integer y = 424
integer width = 347
integer height = 68
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Pa&ginas:"
end type

on clicked;wf_rango_paginas(This)
This.checked= TRUE
sle_rango_paginas.SetFocus()
end on

type rb_todas from radiobutton within w_impresoras_v4
integer x = 142
integer y = 340
integer width = 283
integer height = 68
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Todas"
boolean checked = true
end type

on clicked;wf_rango_paginas(This)
end on

type em_copias from editmask within w_impresoras_v4
integer x = 379
integer y = 144
integer width = 242
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean spin = true
double increment = 1
string minmax = "1~~15"
end type

type st_2 from statictext within w_impresoras_v4
integer x = 37
integer y = 160
integer width = 210
integer height = 68
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Copias:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_impresoras_v4
integer x = 64
integer y = 272
integer width = 1298
integer height = 400
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Rango de Paginas"
end type

type cb_excel from commandbutton within w_impresoras_v4
integer x = 1550
integer y = 600
integer width = 407
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Excel"
end type

event clicked;//report.saveas("c:\formato_web.html", htmltable!, true)
// 
//oleobject excel 
//
//excel = create oleobject 
//
//if excel.connecttonewobject("excel.application") = 0 then 
//	excel.application.displayalerts = false 
//	excel.application.workbooks.open("c:\formato_web.html")
//	excel.application.workbooks(1).parent.windows(excel.application.workbooks(1).name).visible = true 
//	
//	string ande, file
//	
//	if getfilesavename("Elija nombre y ubicacion", ande, file , "XLS", "Libros Excel (*.XLS),*.XLS") = 1 then	
//		excel.application.workbooks(1).saveas(ande, 39) 		
//	end if
//	excel.application.workbooks(1).close() 
//else
//	messagebox("ERROR", "")
//end if 
//
//excel.disconnectobject()
//
//destroy excel 

//string ande, file
//
//if getfilesavename("Elija nombre y ubicacion", ande, file , "XLS", "Libros Excel (*.XLS),*.XLS") = 1 then	
//	uf_save_dw_as_excel(report,ande) 		
//end if
//

Int					li_valor
String			ls_path, ls_file

//Open (w_excel_response)
//
//li_valor = Message.DoubleParm
//
//IF li_valor = 1 THEN
//	IF getfilesavename ( 'Archivos',ls_path,ls_file,'XLS','XLS Files (*.XLS), *.XLS') = 1 THEN 	
//		uf_save_dw_as_excel ( report, ls_file )	// Si es DataWindow	
////		uf_save_ds_as_excel ( dw_1, ls_file )	// Si es DataStore
//	END IF
//ELSEIF li_valor = 2 THEN
//	if getfilesavename ( 'Archivos',ls_path,ls_file,'XLS','XLS Files (*.XLS), *.XLS') = 1 THEN report.saveas(ls_file,Excel5!,TRUE)
//END IF

end event

