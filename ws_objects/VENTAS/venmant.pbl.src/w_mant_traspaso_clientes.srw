$PBExportHeader$w_mant_traspaso_clientes.srw
forward
global type w_mant_traspaso_clientes from window
end type
type st_3 from statictext within w_mant_traspaso_clientes
end type
type cbx_descuento1 from checkbox within w_mant_traspaso_clientes
end type
type cbx_tarifa1 from checkbox within w_mant_traspaso_clientes
end type
type cbx_albaranes from checkbox within w_mant_traspaso_clientes
end type
type cbx_pedidos from checkbox within w_mant_traspaso_clientes
end type
type cbx_articulos from checkbox within w_mant_traspaso_clientes
end type
type resultado from statictext within w_mant_traspaso_clientes
end type
type cb_2 from commandbutton within w_mant_traspaso_clientes
end type
type cb_1 from commandbutton within w_mant_traspaso_clientes
end type
type st_2 from statictext within w_mant_traspaso_clientes
end type
type st_1 from statictext within w_mant_traspaso_clientes
end type
type uo_1 from u_em_campo_2 within w_mant_traspaso_clientes
end type
type uo_cliente from u_em_campo_2 within w_mant_traspaso_clientes
end type
end forward

global type w_mant_traspaso_clientes from window
integer width = 4462
integer height = 1504
boolean titlebar = true
string title = "Traspaso de clientes"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
cbx_descuento1 cbx_descuento1
cbx_tarifa1 cbx_tarifa1
cbx_albaranes cbx_albaranes
cbx_pedidos cbx_pedidos
cbx_articulos cbx_articulos
resultado resultado
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
uo_1 uo_1
uo_cliente uo_cliente
end type
global w_mant_traspaso_clientes w_mant_traspaso_clientes

type variables
Long id_ventana_activa
end variables

on w_mant_traspaso_clientes.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_3=create st_3
this.cbx_descuento1=create cbx_descuento1
this.cbx_tarifa1=create cbx_tarifa1
this.cbx_albaranes=create cbx_albaranes
this.cbx_pedidos=create cbx_pedidos
this.cbx_articulos=create cbx_articulos
this.resultado=create resultado
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.uo_1=create uo_1
this.uo_cliente=create uo_cliente
this.Control[]={this.st_3,&
this.cbx_descuento1,&
this.cbx_tarifa1,&
this.cbx_albaranes,&
this.cbx_pedidos,&
this.cbx_articulos,&
this.resultado,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.uo_1,&
this.uo_cliente}
end on

on w_mant_traspaso_clientes.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.cbx_descuento1)
destroy(this.cbx_tarifa1)
destroy(this.cbx_albaranes)
destroy(this.cbx_pedidos)
destroy(this.cbx_articulos)
destroy(this.resultado)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.uo_cliente)
end on

event activate;//Ventanas en el menú principal
id_ventana_activa = f_menu_insertar_ventana(this)

end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type st_3 from statictext within w_mant_traspaso_clientes
integer x = 96
integer y = 524
integer width = 841
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Elementos que se traspasarán:"
boolean focusrectangle = false
end type

type cbx_descuento1 from checkbox within w_mant_traspaso_clientes
integer x = 1225
integer y = 800
integer width = 910
integer height = 80
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descuentos Especiales Cliente"
boolean checked = true
end type

type cbx_tarifa1 from checkbox within w_mant_traspaso_clientes
integer x = 1225
integer y = 664
integer width = 827
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tarifa Cliente Artículo/Fecha"
boolean checked = true
end type

type cbx_albaranes from checkbox within w_mant_traspaso_clientes
integer x = 242
integer y = 800
integer width = 402
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Albaranes"
boolean checked = true
end type

type cbx_pedidos from checkbox within w_mant_traspaso_clientes
integer x = 242
integer y = 924
integer width = 402
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pedidos"
boolean checked = true
end type

type cbx_articulos from checkbox within w_mant_traspaso_clientes
integer x = 242
integer y = 664
integer width = 411
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Artículos"
boolean checked = true
end type

type resultado from statictext within w_mant_traspaso_clientes
integer x = 2245
integer y = 60
integer width = 2130
integer height = 1192
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_mant_traspaso_clientes
integer x = 1161
integer y = 1112
integer width = 402
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(Parent)
end event

type cb_1 from commandbutton within w_mant_traspaso_clientes
integer x = 571
integer y = 1112
integer width = 402
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Traspasar"
end type

event clicked;String nuevo,antiguo
Boolean fallo_bd,fallo_inicio;
transaction transferencia_cli

fallo_inicio = False;
nuevo = uo_1.em_codigo.text
antiguo = uo_cliente.em_codigo.text

//Comprobar nulos antes
IF IsNull(antiguo) OR antiguo = "" THEN 
	resultado.Text = "Por favor, indique el cliente origen."
	resultado.TextColor = RGB(255,0,0)
	//MessageBox("Error", "Por favor, indique el cliente origen.") 
	fallo_inicio = True
ELSEIF  IsNull(nuevo)  OR nuevo = "" THEN 
		resultado.Text = "Por favor, indique el cliente destino."
		resultado.TextColor = RGB(255,0,0)
		//MessageBox("Error", "Por favor, indique el cliente destino.") 
		fallo_inicio = True
END IF


//Inicio Transferencia y transacción
IF NOT fallo_inicio THEN
	resultado.Text = "Transferiendo datos del cliente "+uo_cliente.em_campo.text+" al cliente "+uo_1.em_campo.text
	fallo_bd = false;
	

	f_crear_transaccion(transferencia_cli, '','',false,'','')
		
	CONNECT USING transferencia_cli;
	//CONNECT USING SQLCA;
	
	resultado.Text = ""
	//Artículos
	IF cbx_articulos.checked THEN
		UPDATE articulos 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Artículos tabla 'articulos'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de artículos.~n"
		END IF
		
	END IF
	
	//Pedidos
	IF cbx_pedidos.checked THEN
		UPDATE venped 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Pedidos tabla 'venped'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de pedidos de la tabla 'venped'.~n"		
		END IF
		
		UPDATE venliped 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Pedidos tabla 'venliped'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de pedidos de la tabla 'venliped'.~n"
		END IF
	END IF
	
	//Albaranes
	IF cbx_albaranes.checked THEN
		UPDATE venalb 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Albaranes tabla 'venalb'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de albaranes de la tabla 'venalb'.~n"
		END IF
		
		UPDATE venlialb 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Albaranes tabla 'venlialb'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de albaranes de la tabla 'venlialb'.~n"
		END IF
	END IF
	
	//Tarifas
	IF cbx_tarifa1.checked THEN
		UPDATE tarifaartclifecha 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Tarifas tabla 'tarifaartclifecha'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de tarifas de artículos.~n"
		END IF
	END IF
	
	//Descuentos especiales
	IF cbx_descuento1.checked THEN
		UPDATE vendtoartcli 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Descuentos Especiales tabla 'vendtoartcli'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de descuentos de la tabla 'vendtoartcli'.~n"
		END IF
				
		UPDATE vendtofamcli 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Descuentos Especiales tabla 'vendtofamcli'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de descuentos de la tabla 'vendtofamcli'.~n"
		END IF
		
		UPDATE vendtofamforcli 
		SET cliente = :nuevo 
		WHERE cliente = :antiguo USING transferencia_cli;
		
		IF transferencia_cli.sqlcode <> 0 THEN
			fallo_bd = true;
			resultado.Text = resultado.Text + "Error en la actualización de Descuentos Especiales tabla 'vendtofamforcli'.~n"
		ELSE
			resultado.Text = resultado.Text + "Se han actualizado " + String(transferencia_cli.SQLNRows) + " filas de descuentos de la tabla 'vendtofamforcli'.~n"
		END IF
	END IF
	
	//verificar éxito consultas
	IF fallo_bd THEN
		ROLLBACK USING transferencia_cli;
		resultado.Text = resultado.Text + "Se han cancelado todos los cambios.~n"
		resultado.TextColor = RGB(255,0,0)
	ELSE
		COMMIT USING transferencia_cli;
		resultado.Text = resultado.Text + "Traspaso realizado con éxito.~n"	
	END IF
	DISCONNECT USING transferencia_cli;
	destroy transferencia_cli
END IF

end event

type st_2 from statictext within w_mant_traspaso_clientes
integer x = 96
integer y = 316
integer width = 407
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente destino"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_mant_traspaso_clientes
integer x = 91
integer y = 144
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente origen"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_1 from u_em_campo_2 within w_mant_traspaso_clientes
event destroy ( )
integer x = 695
integer y = 304
integer width = 1449
integer height = 96
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_1.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_1.em_codigo.text)

IF Trim(uo_1.em_campo.text)="" THEN 
 	IF Trim(uo_1.em_codigo.text)<>"" Then 
		uo_1.em_campo.SetFocus()
	END IF
 	uo_1.em_campo.text=""
 	uo_1.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type uo_cliente from u_em_campo_2 within w_mant_traspaso_clientes
event destroy ( )
integer x = 690
integer y = 132
integer width = 1449
integer height = 96
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

