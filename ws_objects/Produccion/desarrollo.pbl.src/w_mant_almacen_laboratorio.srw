$PBExportHeader$w_mant_almacen_laboratorio.srw
forward
global type w_mant_almacen_laboratorio from window
end type
type pb_1 from picturebutton within w_mant_almacen_laboratorio
end type
type cb_borrar from commandbutton within w_mant_almacen_laboratorio
end type
type cb_insertar from commandbutton within w_mant_almacen_laboratorio
end type
type cb_salir from commandbutton within w_mant_almacen_laboratorio
end type
type cb_grabar from commandbutton within w_mant_almacen_laboratorio
end type
type dw_1 from u_dw within w_mant_almacen_laboratorio
end type
end forward

global type w_mant_almacen_laboratorio from window
integer x = 407
integer y = 16
integer width = 3410
integer height = 2588
boolean titlebar = true
string title = "Selección"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
pb_1 pb_1
cb_borrar cb_borrar
cb_insertar cb_insertar
cb_salir cb_salir
cb_grabar cb_grabar
dw_1 dw_1
end type
global w_mant_almacen_laboratorio w_mant_almacen_laboratorio

on w_mant_almacen_laboratorio.create
this.pb_1=create pb_1
this.cb_borrar=create cb_borrar
this.cb_insertar=create cb_insertar
this.cb_salir=create cb_salir
this.cb_grabar=create cb_grabar
this.dw_1=create dw_1
this.Control[]={this.pb_1,&
this.cb_borrar,&
this.cb_insertar,&
this.cb_salir,&
this.cb_grabar,&
this.dw_1}
end on

on w_mant_almacen_laboratorio.destroy
destroy(this.pb_1)
destroy(this.cb_borrar)
destroy(this.cb_insertar)
destroy(this.cb_salir)
destroy(this.cb_grabar)
destroy(this.dw_1)
end on

event open;This.title = "Ubicaciones de Pantallas de laboratorio"

dw_1.SetTransObject(SQLCA)
dw_1.retrieve (codigo_empresa)
end event

type pb_1 from picturebutton within w_mant_almacen_laboratorio
integer x = 3095
integer y = 492
integer width = 146
integer height = 128
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
alignment htextalign = left!
end type

event clicked;f_imprimir_datawindow(dw_1)
end event

type cb_borrar from commandbutton within w_mant_almacen_laboratorio
integer x = 2976
integer y = 112
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;dw_1.DeleteRow(0)


end event

type cb_insertar from commandbutton within w_mant_almacen_laboratorio
integer x = 2976
integer y = 12
integer width = 370
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;long fila_nueva

fila_nueva = dw_1.InsertRow(0)
dw_1.ScrollToRow(fila_nueva)
dw_1.object.almacen_laboratorio_empresa[dw_1.GetRow()] = codigo_empresa

dw_1.setfocus()

end event

type cb_salir from commandbutton within w_mant_almacen_laboratorio
integer x = 2976
integer y = 312
integer width = 370
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close (Parent)

end event

type cb_grabar from commandbutton within w_mant_almacen_laboratorio
integer x = 2976
integer y = 212
integer width = 370
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;integer rtn

CONNECT USING SQLCA;

dw_1.SetTransObject(SQLCA)
dw_1.accepttext()

rtn = dw_1.Update()

IF rtn = 1  THEN 
	COMMIT USING SQLCA;
ELSE
	ROLLBACK USING SQLCA;
	messagebox("Error","No se guardaron los cambios")
END IF
end event

type dw_1 from u_dw within w_mant_almacen_laboratorio
integer x = 5
integer y = 4
integer width = 2930
integer height = 2496
integer taborder = 60
string dataobject = "dwtc_almacen_laboratorio"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;call super::retrieveend;dw_1.SetRedraw(false)

dw_1.SetSort("codigo D")

dw_1.Sort()

dw_1.SetRedraw(true)

end event

event clicked;call super::clicked;str_parametros lstr_param
Long esta_abierta

choose case dwo.name
	//Ordenación
	case "t_ubicacion"
		dw_1.SetSort("codigo A")
		dw_1.Sort()
	case "t_tipo"
		dw_1.SetSort( "Tipo_pantallas A")
		dw_1.Sort()
	case "t_disponible"
		dw_1.SetSort( "disponible A")
		dw_1.Sort()
	case "t_existencias"
		dw_1.SetSort("total_nuevo A")
		dw_1.Sort()
	case "t_capacidad"
		dw_1.SetSort("capacidad A")
		dw_1.Sort()
	//Acciones
	case "p_tipo"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_almacen_laboratorio_tipo")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.almacen_laboratorio_tipo_pantallas[row]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "w_mant_almacen_laboratorio"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_almacen_laboratorio_tipo, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
end choose


end event

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

if row > 0 then
	CHOOSE CASE dwo.name
		CASE "almacen_laboratorio_tipo_pantallas"
			if dw_1.object.total_nuevo[row] > 0 then
				MessageBox("Error", "No se puede cambiar el tipo de almacén de pantallas si contiene pantallas de otro tipo.")
				dwo.Primary[row] = this.object.tipo_pantallas_actual[Row]
				return 2	
			end if
			
			SELECT almacen_laboratorio_tipo.abreviado
			INTO :resultado
			FROM almacen_laboratorio_tipo
			WHERE empresa = :codigo_empresa
			and almacen_laboratorio_tipo.codigo = :data;
	
			if SQLCA.sqlcode <> 100 then
				this.object.almacen_laboratorio_tipo_abreviado[Row] = resultado
				this.object.tipo_pantallas_actual[Row] = data
			else
				dwo.Primary[row] = ''
				this.object.almacen_laboratorio_tipo_abreviado[Row] = ''
				this.object.tipo_pantallas_actual[Row] = ''
				return 2			
			end if
	END CHOOSE
end if
end event

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "almacen_laboratorio_tipo_pantallas"
			if dw_1.object.total_nuevo[dw_1.getrow()] > 0 then
				MessageBox("Error", "No se puede cambiar el tipo de almacén de pantallas si contiene pantallas de otro tipo.")
				return
			end if
			
			busqueda.titulo_ventana = "Búsqueda de Tipo de Ubicaciones"
			busqueda.consulta  = " SELECT codigo, abreviado, descripcion "+&
										" FROM almacen_laboratorio_tipo "+&
										" WHERE empresa = '"+codigo_empresa+"' "+&
										" ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.almacen_laboratorio_tipo_pantallas[dw_1.getrow()] 	= resultado.valores[1]		
				dw_1.object.almacen_laboratorio_tipo_abreviado[dw_1.getrow()]	= resultado.valores[2]		
				dw_1.object.tipo_pantallas_actual[dw_1.getrow()]	= resultado.valores[1]		
			end if
	END CHOOSE
end if
end event

