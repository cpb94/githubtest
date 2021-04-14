$PBExportHeader$wtc_mant_enviar_correo.srw
forward
global type wtc_mant_enviar_correo from wt_ventana_padre
end type
type pb_1 from picturebutton within wtc_mant_enviar_correo
end type
type sle_destino from singlelineedit within wtc_mant_enviar_correo
end type
type cbx_html from checkbox within wtc_mant_enviar_correo
end type
end forward

global type wtc_mant_enviar_correo from wt_ventana_padre
integer width = 3090
integer height = 1936
string title = "Mantenimiento de Clientes"
pb_1 pb_1
sle_destino sle_destino
cbx_html cbx_html
end type
global wtc_mant_enviar_correo wtc_mant_enviar_correo

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();string campo, motivo
boolean falta_Campo
Int resultado

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "mail"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

rtn = 1

resultado = 1 //Todo ok si devolvemos 1

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.descripcion[dw_1.getrow()])) = "" then
		  campo = "descripcion"
		  motivo = "Campo Obligatorio: Descripcion. "
		  falta_campo = True
	end if
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if


rtn = super::f_guardar()


IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF

estado = 1 // Modo edición
dw_1.settransobject(sqlca)
return rtn
end function

on wtc_mant_enviar_correo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.sle_destino=create sle_destino
this.cbx_html=create cbx_html
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.sle_destino
this.Control[iCurrent+3]=this.cbx_html
end on

on wtc_mant_enviar_correo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.sle_destino)
destroy(this.cbx_html)
end on

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_enviar_correo
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_enviar_correo
integer x = 2505
integer y = 24
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_enviar_correo
integer y = 316
integer width = 3008
integer height = 1420
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_enviar_correo"
boolean border = false
end type

event dw_1::clicked;call super::clicked;string is_fullname, is_filename

if dwo.name = "p_carpeta" then
	GetFileOpenName ("Adjuntar", is_fullname, is_filename)
	
	dw_1.object.adjunto[1] = is_fullname
	
end if

end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_enviar_correo
integer x = 2551
integer y = 140
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_enviar_correo
integer x = 2862
integer y = 140
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_enviar_correo
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_enviar_correo
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_enviar_correo
end type

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_enviar_correo
integer x = 2706
integer y = 140
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_enviar_correo
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, descripcion "+&
											" FROM mail "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
	
	case "descripcion"
		padre_busqueda.consulta =  " SELECT codigo, descripcion "+&
											" FROM mail "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY descripcion ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"			
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT codigo, codigo, descripcion "+&
											" FROM mail "+&
											" WHERE empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, codigo) ASC"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"
end choose


call super :: clicked
end event

type pb_1 from picturebutton within wtc_mant_enviar_correo
integer x = 763
integer y = 160
integer width = 352
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mail"
boolean originalsize = true
end type

event clicked;string lista_destinatarios
string asunto, cuerpo_mensaje, adjunto 
string razon, sel_emails, cliente
datastore regs_email
int i, resultado

if dw_1.rowcount() > 0 then
	asunto = dw_1.object.asunto[1]
	cuerpo_mensaje = dw_1.object.cuerpo[1]
	adjunto = dw_1.object.adjunto[1]

	if  sle_destino.text <> '' then
		resultado = messagebox ("Aviso", "Se enviará un correo a "+sle_destino.text+" ~n ¿Desea continuar?", Exclamation!, YesNo!, 2)
		lista_destinatarios = sle_destino.text
	else
		resultado = messagebox ("Aviso", "Se enviará un correo a TODOS LOS CLIENTES de la base datos ~n ¿Desea continuar?", Exclamation!, YesNo!, 2)

		sel_emails = " select email "+&
						" from venclientes_email "+&
						" where empresa = '"+codigo_empresa+"' "+&
						" and tipo = 1 "
						
		f_cargar_cursor_nuevo (sel_emails, regs_email)
	
		for i = 1 to regs_email.rowcount()
			if lista_destinatarios = '' then
				lista_destinatarios = regs_email.object.email[i]
			else
				lista_destinatarios = 	lista_destinatarios +", "+ regs_email.object.email[i]
			end if
		next
	end if

	if lista_destinatarios <> ''  and resultado = 1 then		
		// Envio de Html
		if cbx_html.checked then
			run('C:\tencer_pb12\blat.exe '+adjunto+' -server smtp.tendenciasceramicas.com -port 25 '+&
					' -f "pedidos@tendenciasceramicas.com" -bcc "'+lista_destinatarios+'" '+&
					' -subject "'+asunto+'" '+&
					' -u pedidos.tendenciasceramicas.com -pw #30Octubre', minimized!)
		else
			if adjunto <> "" and resultado = 1 then
				run('C:\tencer_pb12\blat.exe -server smtp.tendenciasceramicas.com -port 25 '+&
						' -f "pedidos@tendenciasceramicas.com" -bcc "'+lista_destinatarios+'" '+&
						' -subject "'+asunto+'" '+&
						' -body "'+cuerpo_mensaje+'" '+&
						' -u pedidos.tendenciasceramicas.com -pw #30Octubre -attach "'+adjunto+'" ', minimized!)
				
			else
				if adjunto = '' and resultado = 1 then
					run('C:\tencer_pb12\blat.exe -server smtp.tendenciasceramicas.com -port 25 '+&
							' -f "pedidos@tendenciasceramicas.com" -bcc "'+lista_destinatarios+'" '+&
							' -subject "'+asunto+'" '+&
							' -body "'+cuerpo_mensaje+'" '+&
							' -u pedidos.tendenciasceramicas.com -pw #30Octubre', minimized!)
				end if
			end if
					
		end if
		
						

//				run('C:\tencer_pb12\blat.exe c:\temp\carta.html -server smtp.tendenciasceramicas.com -port 25 '+&
//				' -f "pedidos@tendenciasceramicas.com" -bcc "'+lista_destinatarios+'" '+&
//				' -subject "'+asunto+'" '+&
//				' -u pedidos.tendenciasceramicas.com -pw 1.pbeltran -attach "'+adjunto+'" ', minimized!)
//
	
//		run('C:\tencer_pb12\blat.exe -server smtp.tendenciasceramicas.com -port 25 '+&
//				' -f "pedidos@tendenciasceramicas.com" -to "'+lista_destinatarios+'" '+&
//				' -subject "'+asunto+'" '+&
//				' -body "'+cuerpo_mensaje+'" '+&
//				' -u pedidos.tendenciasceramicas.com -pw 1.pbeltran -attach "'+adjunto+'" ', minimized!)
	
	else
		messagebox ("Atención", razon+" No hay dirección de correo.", Exclamation!,  OK!)
	end if
end if	
	

end event

type sle_destino from singlelineedit within wtc_mant_enviar_correo
integer x = 1138
integer y = 164
integer width = 1344
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "pedidos@tendenciasceramicas.com"
borderstyle borderstyle = stylelowered!
end type

type cbx_html from checkbox within wtc_mant_enviar_correo
integer x = 1861
integer y = 76
integer width = 539
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Html Incrustado"
boolean lefttext = true
end type

event clicked;if this.checked = true then
	dw_1.object.t_adjunto.text = "Archivo html"
	dw_1.object.cuerpo.Background.Color = RGB(10, 10, 10)	
else
	dw_1.object.cuerpo.Background.Color = RGB(255, 255, 255)
	dw_1.object.t_adjunto.text = "Adjunto"
end if
end event

