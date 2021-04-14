$PBExportHeader$w_gestion_pagos_a_cuenta_cliente.srw
forward
global type w_gestion_pagos_a_cuenta_cliente from w_int_con_empresa
end type
type pb_2 from upb_salir within w_gestion_pagos_a_cuenta_cliente
end type
type gb_3 from groupbox within w_gestion_pagos_a_cuenta_cliente
end type
type gb_2 from groupbox within w_gestion_pagos_a_cuenta_cliente
end type
type uo_cliente from u_em_campo_2 within w_gestion_pagos_a_cuenta_cliente
end type
type gb_cuenta from groupbox within w_gestion_pagos_a_cuenta_cliente
end type
type st_1 from statictext within w_gestion_pagos_a_cuenta_cliente
end type
type em_fechadesde from u_em_campo within w_gestion_pagos_a_cuenta_cliente
end type
type em_fechahasta from u_em_campo within w_gestion_pagos_a_cuenta_cliente
end type
type st_8 from statictext within w_gestion_pagos_a_cuenta_cliente
end type
type st_9 from statictext within w_gestion_pagos_a_cuenta_cliente
end type
type dw_pagos_a_cuenta_asignados from datawindow within w_gestion_pagos_a_cuenta_cliente
end type
type dw_efectos_cliente from datawindow within w_gestion_pagos_a_cuenta_cliente
end type
type dw_detalle_pagos_a_cuenta_asignados from datawindow within w_gestion_pagos_a_cuenta_cliente
end type
type cb_asignar from commandbutton within w_gestion_pagos_a_cuenta_cliente
end type
type dw_pagos_a_cuenta_pendientes from datawindow within w_gestion_pagos_a_cuenta_cliente
end type
type cb_consulta from commandbutton within w_gestion_pagos_a_cuenta_cliente
end type
type em_pendiente_asignar from editmask within w_gestion_pagos_a_cuenta_cliente
end type
type st_2 from statictext within w_gestion_pagos_a_cuenta_cliente
end type
type cb_quitar from commandbutton within w_gestion_pagos_a_cuenta_cliente
end type
type cb_asignar_sin_detalle from picturebutton within w_gestion_pagos_a_cuenta_cliente
end type
end forward

global type w_gestion_pagos_a_cuenta_cliente from w_int_con_empresa
integer x = 5
integer y = 268
integer width = 3643
integer height = 2384
pb_2 pb_2
gb_3 gb_3
gb_2 gb_2
uo_cliente uo_cliente
gb_cuenta gb_cuenta
st_1 st_1
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_8 st_8
st_9 st_9
dw_pagos_a_cuenta_asignados dw_pagos_a_cuenta_asignados
dw_efectos_cliente dw_efectos_cliente
dw_detalle_pagos_a_cuenta_asignados dw_detalle_pagos_a_cuenta_asignados
cb_asignar cb_asignar
dw_pagos_a_cuenta_pendientes dw_pagos_a_cuenta_pendientes
cb_consulta cb_consulta
em_pendiente_asignar em_pendiente_asignar
st_2 st_2
cb_quitar cb_quitar
cb_asignar_sin_detalle cb_asignar_sin_detalle
end type
global w_gestion_pagos_a_cuenta_cliente w_gestion_pagos_a_cuenta_cliente

type variables
String ante_articulo,retrasos,isle_campo
end variables

forward prototypes
public subroutine f_mostrar_pagos_a_cuenta_sin_asignar (datawindow data)
public subroutine f_mostrar_pagos_pendientes (datawindow data)
public subroutine f_mostrar_pagos_a_cuenta_asignados (datawindow data)
public subroutine f_asignar ()
public function boolean f_dividir_efecto (integer arg_anyo, long arg_orden, string arg_historico, integer arg_linea, decimal arg_nuevo_importe)
public function boolean f_pasar_efecto_historico (integer arg_anyo, long arg_orden, integer arg_linea)
public subroutine f_quitar ()
public subroutine f_mostrar_detalle_pago_a_cuenta_asignado (datawindow data, integer arg_anyoagrupa, long arg_efectoagrupa, integer arg_linea_historico, string arg_historico)
public subroutine f_asignar_sin_detalle ()
end prototypes

public subroutine f_mostrar_pagos_a_cuenta_sin_asignar (datawindow data);long   indice,total,donde
string cliente,sel
string factura,moneda,situacion,tipodoc,historico,cobrado,moneda_empresa
int    anyo,anyofra,linea_historico,orden,recibo
dec    cambio,divisas,importe
datetime fcobro,fvto

datastore datos

data.setredraw(false)
data.reset()

moneda_empresa = f_moneda_empresa(codigo_empresa)

cliente = uo_cliente.em_codigo.text

sel = "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,0 linea_historico,"+&
		"       monedas,orden,recibo,situacion,tipodoc,'N' historico "+&
		"FROM   carefectos "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       = '"+cliente+"' "+&
		"AND    pago_a_cuenta = 'S' "+&
		"AND    agrupado      = 'N' "+&
		"UNION "+&
      "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,linea linea_historico,"+&
		"       monedas,orden,recibo,situacion,tipodoc,'S' historico "+&
		"FROM   carhistorico "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       = '"+cliente+"' "+&
		"AND    pago_a_cuenta = 'S' "+&
		"AND    agrupado      = 'N'"
		
		
datos = f_cargar_cursor(sel)	

total = datos.rowcount()

for indice = 1 to total
	anyo            = datos.object.anyo[indice]
	anyofra         = datos.object.anyofra[indice]
	cambio          = datos.object.cambio[indice]
	divisas         = datos.object.divisas[indice]
	factura         = datos.object.factura[indice]
	fcobro          = datos.object.fcobro[indice]
	fvto            = datos.object.fvto[indice]
	importe         = datos.object.importe[indice]
	linea_historico = datos.object.linea_historico[indice]
	moneda          = datos.object.monedas[indice]
	orden           = datos.object.orden[indice]
	recibo          = datos.object.recibo[indice]
	situacion       = datos.object.situacion[indice]
	tipodoc         = datos.object.tipodoc[indice]
	historico       = datos.object.historico[indice]
	
	if situacion = "9" then
		cobrado = "S"
	else
		cobrado = "N"
	end if
	
	donde = data.insertrow(0)
	
	data.object.anyo[donde]            = anyo
	data.object.anyofra[donde]         = anyofra
	data.object.cambio[donde]          = cambio
	data.object.cobrado[donde]         = cobrado
	data.object.divisas[donde]         = divisas
	data.object.empresa[donde]         = codigo_empresa
	data.object.factura[donde]         = factura
	data.object.fcobro[donde]          = fcobro
	data.object.fvto[donde]            = fvto
	data.object.importe[donde]         = importe
	data.object.linea_historico[donde] = linea_historico 
	data.object.moneda[donde]          = moneda
	data.object.moneda_empresa[donde]  = moneda_empresa
	data.object.orden[donde]           = orden
	data.object.recibo[donde]          = recibo
	data.object.situacion[donde]       = situacion
	data.object.tipodoc[donde]         = tipodoc
	data.object.historico[donde]       = historico
	
next

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_mostrar_pagos_pendientes (datawindow data);long     indice,total,donde
string   cliente,sel
datetime f_desde,f_hasta
string   factura,moneda,situacion,tipodoc,historico,cobrado,moneda_empresa
int      anyo,anyofra,linea_historico,orden,recibo
dec      cambio,divisas,importe
datetime fcobro,fvto,ffra

datastore datos

data.setredraw(false)
data.reset()

moneda_empresa = f_moneda_empresa(codigo_empresa)

cliente = uo_cliente.em_codigo.text
f_desde = datetime(date(em_fechadesde.text))
f_hasta = datetime(date(em_fechahasta.text))

sel = "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,"+&
		"       monedas,orden,recibo,situacion,tipodoc,ffra "+&
		"FROM   carefectos "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       = '"+cliente+"' "+&
		"AND    ffra between '"+string(f_desde,formato_fecha_cursores)+"' and '"+string(f_hasta,formato_fecha_cursores)+"' "+&
		"AND    pago_a_cuenta = 'N' "+&
		"AND    agrupado <> 'S' "+&
		"AND    situacion in('0','2','4','10') "

//Seleccionamos los efectos en situación :cartera,Devuelto,Pre cartera,Pendiente de recibir
			
datos = f_cargar_cursor(sel)	

total = datos.rowcount()

for indice = 1 to total
	anyo            = datos.object.anyo[indice]
	anyofra         = datos.object.anyofra[indice]
	cambio          = datos.object.cambio[indice]
	divisas         = datos.object.divisas[indice]
	factura         = datos.object.factura[indice]
	fcobro          = datos.object.fcobro[indice]
	fvto            = datos.object.fvto[indice]
	importe         = datos.object.importe[indice]
	moneda          = datos.object.monedas[indice]
	orden           = datos.object.orden[indice]
	recibo          = datos.object.recibo[indice]
	situacion       = datos.object.situacion[indice]
	tipodoc         = datos.object.tipodoc[indice]
	ffra            = datos.object.ffra[indice]
		
	donde = data.insertrow(0)
	
	data.object.anyo[donde]            = anyo
	data.object.anyofra[donde]         = anyofra
	data.object.cambio[donde]          = cambio	
	data.object.divisas[donde]         = divisas
	data.object.empresa[donde]         = codigo_empresa
	data.object.factura[donde]         = factura
	data.object.fcobro[donde]          = fcobro
	data.object.fvto[donde]            = fvto
	data.object.importe[donde]         = importe
	data.object.moneda[donde]          = moneda
	data.object.moneda_empresa[donde]  = moneda_empresa
	data.object.orden[donde]           = orden
	data.object.recibo[donde]          = recibo
	data.object.situacion[donde]       = situacion
	data.object.tipodoc[donde]         = tipodoc
	data.object.ffra[donde]            = ffra
	data.object.marca[donde]           = "N"
next

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_mostrar_pagos_a_cuenta_asignados (datawindow data);long   indice,total,donde
string cliente,sel
string factura,moneda,situacion,tipodoc,historico,cobrado,moneda_empresa
int    anyo,anyofra,linea_historico,orden,recibo
dec    cambio,divisas,importe
datetime fcobro,fvto

datastore datos

data.setredraw(false)
data.reset()

moneda_empresa = f_moneda_empresa(codigo_empresa)

cliente = uo_cliente.em_codigo.text

sel = "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,0 linea_historico,"+&
		"       monedas,orden,recibo,situacion,tipodoc,'N' historico "+&
		"FROM   carefectos "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       = '"+cliente+"' "+&
		"AND    pago_a_cuenta = 'S' "+&
		"AND    agrupado      = 'S' "+&
		"UNION "+&
      "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,linea linea_historico,"+&
		"       monedas,orden,recibo,situacion,tipodoc,'S' historico "+&
		"FROM   carhistorico "+&
		"WHERE  empresa       = '"+codigo_empresa+"' "+&
		"AND    cliente       = '"+cliente+"' "+&
		"AND    pago_a_cuenta = 'S' "+&
		"AND    agrupado      = 'S'"
		
		
datos = f_cargar_cursor(sel)	

total = datos.rowcount()

for indice = 1 to total
	anyo            = datos.object.anyo[indice]
	anyofra         = datos.object.anyofra[indice]
	cambio          = datos.object.cambio[indice]
	divisas         = datos.object.divisas[indice]
	factura         = datos.object.factura[indice]
	fcobro          = datos.object.fcobro[indice]
	fvto            = datos.object.fvto[indice]
	importe         = datos.object.importe[indice]
	linea_historico = datos.object.linea_historico[indice]
	moneda          = datos.object.monedas[indice]
	orden           = datos.object.orden[indice]
	recibo          = datos.object.recibo[indice]
	situacion       = datos.object.situacion[indice]
	tipodoc         = datos.object.tipodoc[indice]
	historico       = datos.object.historico[indice]
	
	if situacion = "9" then
		cobrado = "S"
	else
		cobrado = "N"
	end if
	
	donde = data.insertrow(0)
	
	data.object.anyo[donde]            = anyo
	data.object.anyofra[donde]         = anyofra
	data.object.cambio[donde]          = cambio
	data.object.cobrado[donde]         = cobrado
	data.object.divisas[donde]         = divisas
	data.object.empresa[donde]         = codigo_empresa
	data.object.factura[donde]         = factura
	data.object.fcobro[donde]          = fcobro
	data.object.fvto[donde]            = fvto
	data.object.importe[donde]         = importe
	data.object.linea_historico[donde] = linea_historico 
	data.object.moneda[donde]          = moneda
	data.object.moneda_empresa[donde]  = moneda_empresa
	data.object.orden[donde]           = orden
	data.object.recibo[donde]          = recibo
	data.object.situacion[donde]       = situacion
	data.object.tipodoc[donde]         = tipodoc
	data.object.historico[donde]       = historico
	
next

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_asignar ();string  historico
long    donde,indice,total,anyo,orden
int     anyo_agrupa,efecto_agrupa,linea_historico
dec     importe_efecto,importe_asignado,importe_total_asignado
boolean bien = true,continuar = true

if dec(em_pendiente_asignar.text) <> 0 then
	if messagebox("Atención","¿Desea realizar la asiganación parcial?",Question!,YesNo!,1) = 2 then
		continuar = false
	end if	
end if

if continuar then
	donde = dw_pagos_a_cuenta_pendientes.getrow()
	if donde > 0 then
		anyo_agrupa     = dw_pagos_a_cuenta_pendientes.object.anyo[donde]
		efecto_agrupa   = dw_pagos_a_cuenta_pendientes.object.orden[donde]
		historico       = dw_pagos_a_cuenta_pendientes.object.historico[donde]
		linea_historico = dw_pagos_a_cuenta_pendientes.object.linea_historico[donde]
		
		if dec(em_pendiente_asignar.text) <> 0 then
			importe_total_asignado = dw_pagos_a_cuenta_pendientes.object.importe[donde] - dec(em_pendiente_asignar.text)
			if not f_dividir_efecto(anyo_agrupa,efecto_agrupa,historico,linea_historico,importe_total_asignado) then
				bien = false
			end if
		end if
		
		total = dw_efectos_cliente.rowcount()
		for indice = 1 to total
			if dw_efectos_cliente.object.marca[indice] = "S" then 
				importe_efecto   = dw_efectos_cliente.object.importe[indice]
				importe_asignado = dw_efectos_cliente.object.importe_asignado[indice]
				
				if importe_asignado <> 0 then
					anyo  = dw_efectos_cliente.object.anyo[indice]
					orden = dw_efectos_cliente.object.orden[indice]
					if importe_asignado < importe_efecto then
						if not f_dividir_efecto(anyo,orden,"N",0,importe_asignado) then
							bien = false
						end if
					end if									
					
					update carefectos
					set    anyoagrupa   = :anyo_agrupa,
							 efectoagrupa = :efecto_agrupa,
							 situacion    = '3'
					where  empresa      = :codigo_empresa
					and    anyo         = :anyo
					and    orden        = :orden;
					
					if sqlca.sqlcode <> 0 then 
						bien = false					
					end if
					
					if historico = "S" then
						if not(f_pasar_efecto_historico(anyo,orden,linea_historico)) then
							bien = false	
						end if
					end if
				end if
			end if
		next
		
		if historico = "N" then
			update carefectos
			set    agrupado = 'S'
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo_agrupa
			and    orden        = :efecto_agrupa;
			
			if sqlca.sqlcode <> 0 then 
				bien = false					
			end if
		else						
			update carhistorico
			set    agrupado = 'S'
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo_agrupa
			and    orden        = :efecto_agrupa
			and    linea        = :linea_historico;
			
			if sqlca.sqlcode <> 0 then 
				bien = false					
			end if			
		end if
		
		if bien then
			commit;
		else
			rollback;
			messagebox("Atención Error","La operación no se actualiza.")
		end if
	end if
end if

end subroutine

public function boolean f_dividir_efecto (integer arg_anyo, long arg_orden, string arg_historico, integer arg_linea, decimal arg_nuevo_importe);long    ll_max_recibo
boolean bien = true

str_carefectos carefectos
str_carhistorico carhistorico

if arg_historico = "N" then

	if not(f_cargar_str_carefectos(codigo_empresa,arg_anyo,arg_orden,carefectos)) then
		bien = false	
	end if
	
	UPDATE carefectos
	SET    importe = :arg_nuevo_importe,
			 divisas = :arg_nuevo_importe / cambio
	WHERE  empresa = :codigo_empresa
	AND    anyo    = :arg_anyo
	AND    orden   = :arg_orden;
	
	if sqlca.sqlcode <> 0 then
		bien = false	
	end if
	
	select isnull(max(recibo),0)
	into   :ll_max_recibo
	from   (select isnull(max(carefectos.recibo),0) as recibo 
			  from   carefectos
			  where  carefectos.empresa = :codigo_empresa 
			  and    carefectos.anyofra = :carefectos.anyofra
			  and    carefectos.factura = :carefectos.factura
			  union all 
			  select isnull(max(carhistorico.recibo),0) as recibo 
			  from   carhistorico
			  where  carhistorico.empresa = :codigo_empresa 
			  and    carhistorico.anyofra = :carefectos.anyofra
			  and    carhistorico.factura = :carefectos.factura) as subconsulta;
	
	ll_max_recibo ++
	
	carefectos.empresa = codigo_empresa
	carefectos.anyo    = arg_anyo
	carefectos.orden   = f_orden_carparam(codigo_empresa,arg_anyo)
	carefectos.importe = carefectos.importe - arg_nuevo_importe
	carefectos.divisas = carefectos.importe / carefectos.cambio
	carefectos.recibo  = ll_max_recibo
	
	if not(f_insert_carefectos(carefectos)) then
		bien = false
	end if
else
	//Efecto en el historico	
	if not(f_cargar_str_carhistorico(codigo_empresa,arg_anyo,arg_orden,arg_linea,carhistorico)) then
		bien = false	
	end if
	
	UPDATE carhistorico
	SET    importe = :arg_nuevo_importe,
			 divisas = :arg_nuevo_importe / cambio
	WHERE  empresa = :codigo_empresa
	AND    anyo    = :arg_anyo
	AND    orden   = :arg_orden
	AND    linea   = :arg_linea;
	
	if sqlca.sqlcode <> 0 then
		bien = false	
	end if
	
	select isnull(max(recibo),0)
	into   :ll_max_recibo
	from   (select isnull(max(carefectos.recibo),0) as recibo 
			  from   carefectos
			  where  carefectos.empresa = :codigo_empresa 
			  and    carefectos.anyofra = :carhistorico.anyofra
			  and    carefectos.factura = :carhistorico.factura
			  union all 
			  select isnull(max(carhistorico.recibo),0) as recibo 
			  from   carhistorico
			  where  carhistorico.empresa = :codigo_empresa 
			  and    carhistorico.anyofra = :carhistorico.anyofra
			  and    carhistorico.factura = :carhistorico.factura) as subconsulta;
	
	ll_max_recibo ++	
	
	carhistorico.empresa = codigo_empresa
	carhistorico.anyo    = arg_anyo
	carhistorico.orden   = f_orden_carparam(codigo_empresa,arg_anyo)
	carhistorico.linea   = 1
	carhistorico.importe = carhistorico.importe - arg_nuevo_importe
	carhistorico.divisas = carhistorico.importe / carhistorico.cambio
	carhistorico.recibo  = ll_max_recibo
	
	if not(f_insert_carhistorico(carhistorico)) then
		bien = false
	end if
	
end if

return bien
end function

public function boolean f_pasar_efecto_historico (integer arg_anyo, long arg_orden, integer arg_linea);long    ll_existe_historico,ll_nueva_orden
boolean bien = true

str_carefectos lstr_carefectos
str_carhistorico lstr_carhistorico

if not(f_cargar_str_carefectos(codigo_empresa,arg_anyo,arg_orden,lstr_carefectos)) then
	bien = false	
else
	f_pasa_str_carefectos_a_str_carhistorico(lstr_carefectos,lstr_carhistorico)
end if
		
select isnull(count(*),0)
into   :ll_existe_historico
from   carhistorico
WHERE  empresa = :codigo_empresa
AND    anyo    = :arg_anyo
AND    orden   = :arg_orden;
		
if ll_existe_historico = 0 then		
	lstr_carhistorico.orden = arg_orden
else
	lstr_carhistorico.orden = f_orden_carparam(codigo_empresa,arg_anyo)
end if

lstr_carhistorico.empresa = codigo_empresa
lstr_carhistorico.anyo    = arg_anyo
lstr_carhistorico.linea   = arg_linea

if not(f_insert_carhistorico(lstr_carhistorico)) then
	bien = false
end if

delete carefectos
where  empresa = :codigo_empresa
and    anyo    = :arg_anyo
and    orden   = :arg_orden;

if sqlca.sqlcode <> 0 then
	bien = false	
end if

// COMPRUEBO SI QUEDA ALGÚN RECIBO POR COBRAR
long ll_cuantos_recibos,ll_factura

SELECT count(carefectos.recibo)  
INTO   :ll_cuantos_recibos  
FROM   carefectos  
WHERE ( carefectos.empresa = :lstr_carhistorico.empresa )
AND  	( carefectos.anyofra = :lstr_carhistorico.anyofra )
AND  	( carefectos.factura = :lstr_carhistorico.factura );

if isnull(ll_cuantos_recibos) then ll_cuantos_recibos = 0

if ll_cuantos_recibos = 0 then
	ll_factura = Dec(lstr_carhistorico.factura)
	
	lstr_carhistorico.fcobro = datetime(today())
	
	UPDATE carcomisiones 
	SET    carcomisiones.cobrado = "S",
			 carcomisiones.fcobro  = :lstr_carhistorico.fcobro
	WHERE  carcomisiones.empresa = :lstr_carhistorico.empresa
	AND    carcomisiones.anyo    = :lstr_carhistorico.anyofra
	AND    carcomisiones.factura = :ll_factura;
	
	if SQLCA.SQLCODE <> 0 Then 
		bien = false
	end if
end if		

return bien
end function

public subroutine f_quitar ();string  historico
long    donde,indice,total,anyo,orden
long    anyo_agrupa,efecto_agrupa,linea_historico,linea_historico_detalle
boolean bien = true
str_carhistorico lstr_carhistorico
str_carefectos   lstr_carefectos

donde = dw_pagos_a_cuenta_asignados.getrow()
if donde > 0 then
	anyo_agrupa     = dw_pagos_a_cuenta_asignados.object.anyo[donde]
	efecto_agrupa   = dw_pagos_a_cuenta_asignados.object.orden[donde]
	historico       = dw_pagos_a_cuenta_asignados.object.historico[donde]
	linea_historico = dw_pagos_a_cuenta_asignados.object.linea_historico[donde]
	
	if historico = "N" then
		total = dw_detalle_pagos_a_cuenta_asignados.rowcount()
		
		for indice = 1 to total
			anyo  = dw_detalle_pagos_a_cuenta_asignados.object.anyo[indice]
			orden = dw_detalle_pagos_a_cuenta_asignados.object.orden[indice]
			
			
			update carefectos
			set    anyoagrupa   = 0,
					 efectoagrupa = 0,
					 situacion    = '0'
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo
			and    orden        = :orden;
					
			if sqlca.sqlcode <> 0 then 
				bien = false					
			end if
		next						
		
		update carefectos
		set    agrupado = 'N'
		where  empresa      = :codigo_empresa
		and    anyo         = :anyo_agrupa
		and    orden        = :efecto_agrupa;
		
		if sqlca.sqlcode <> 0 then 
			bien = false					
		end if
	else			
		total = dw_detalle_pagos_a_cuenta_asignados.rowcount()
		
		for indice = 1 to total
			anyo                    = dw_detalle_pagos_a_cuenta_asignados.object.anyo[indice]
			orden                   = dw_detalle_pagos_a_cuenta_asignados.object.orden[indice]
			linea_historico_detalle = dw_detalle_pagos_a_cuenta_asignados.object.linea_historico[indice]
			if not(f_cargar_str_carhistorico(codigo_empresa,anyo,orden,linea_historico_detalle,lstr_carhistorico)) then
				bien = false	
			end if
			
			f_pasa_str_carhistorico_a_str_carefectos(lstr_carhistorico,lstr_carefectos)
			
			lstr_carefectos.anyoagrupa   = 0
			lstr_carefectos.efectoagrupa = 0
			lstr_carefectos.situacion    = '0'
			
			delete carhistorico
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo
			and    orden        = :orden
			and    linea        = :linea_historico_detalle;
					
			if sqlca.sqlcode <> 0 then 
				bien = false			
			else
				if not(f_insert_carefectos(lstr_carefectos)) then
					bien = false			
				end if
			end if
			
			// COMPRUEBO SI QUEDA ALGÚN RECIBO POR COBRAR
			long ll_cuantos_recibos,ll_factura
			
			SELECT count(carefectos.recibo)  
			INTO   :ll_cuantos_recibos  
			FROM   carefectos  
			WHERE ( carefectos.empresa = :lstr_carefectos.empresa )
			AND  	( carefectos.anyofra = :lstr_carefectos.anyofra )
			AND  	( carefectos.factura = :lstr_carefectos.factura );
			
			if isnull(ll_cuantos_recibos) then ll_cuantos_recibos = 0
			
			if ll_cuantos_recibos > 0 then
				ll_factura = Dec(lstr_carefectos.factura)
				
				setnull(lstr_carefectos.fcobro)
				
				UPDATE carcomisiones 
				SET    carcomisiones.cobrado = "N",
						 carcomisiones.fcobro  = :lstr_carefectos.fcobro
				WHERE  carcomisiones.empresa = :lstr_carefectos.empresa
				AND    carcomisiones.anyo    = :lstr_carefectos.anyofra
				AND    carcomisiones.factura = :ll_factura;
				
				if SQLCA.SQLCODE <> 0 Then 
					bien = false
				end if
			end if					
			
		next										
		
		update carhistorico
		set    agrupado = 'N'
		where  empresa      = :codigo_empresa
		and    anyo         = :anyo_agrupa
		and    orden        = :efecto_agrupa
		and    linea        = :linea_historico;
		
		if sqlca.sqlcode <> 0 then 
			bien = false					
		end if			
	end if
	
	if bien then
		commit;
	else
		rollback;
		messagebox("Atención Error","La operación no se actualiza.")
	end if
end if

end subroutine

public subroutine f_mostrar_detalle_pago_a_cuenta_asignado (datawindow data, integer arg_anyoagrupa, long arg_efectoagrupa, integer arg_linea_historico, string arg_historico);long     indice,total,donde
string   cliente,sel
datetime f_desde,f_hasta
string   factura,moneda,situacion,tipodoc,historico,cobrado,moneda_empresa
int      anyo,anyofra,linea_historico,orden,recibo
dec      cambio,divisas,importe
datetime fcobro,fvto,ffra

datastore datos

data.setredraw(false)
data.reset()

moneda_empresa = f_moneda_empresa(codigo_empresa)

if arg_historico = "N" then
	sel = "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,"+&
			"       monedas,orden,recibo,situacion,tipodoc,ffra "+&
			"FROM   carefectos "+&
			"WHERE  empresa       = '"+codigo_empresa+"' "+&
			"AND    anyoagrupa    = "+string(arg_anyoagrupa,"####")+" "+&
			"AND    efectoagrupa  = "+string(arg_efectoagrupa,"#######")+" "+&
			"AND    situacion     = '3'"
else
	sel = "SELECT anyo,anyofra,cambio,divisas,factura,fcobro,fvto,importe,"+&
			"       monedas,orden,recibo,situacion,tipodoc,ffra "+&
			"FROM   carhistorico "+&
			"WHERE  empresa       = '"+codigo_empresa+"' "+&
			"AND    anyoagrupa    = "+string(arg_anyoagrupa,"####")+" "+&
			"AND    efectoagrupa  = "+string(arg_efectoagrupa,"#######")+" "+&
			"AND    linea         = "+string(arg_linea_historico,"###")+" "+&
			"AND    situacion     = '3'"	
end if
				
datos = f_cargar_cursor(sel)	

total = datos.rowcount()

for indice = 1 to total
	anyo            = datos.object.anyo[indice]
	anyofra         = datos.object.anyofra[indice]
	cambio          = datos.object.cambio[indice]
	divisas         = datos.object.divisas[indice]
	factura         = datos.object.factura[indice]
	fcobro          = datos.object.fcobro[indice]
	fvto            = datos.object.fvto[indice]
	importe         = datos.object.importe[indice]
	moneda          = datos.object.monedas[indice]
	orden           = datos.object.orden[indice]
	recibo          = datos.object.recibo[indice]
	situacion       = datos.object.situacion[indice]
	tipodoc         = datos.object.tipodoc[indice]
	ffra            = datos.object.ffra[indice]
		
	donde = data.insertrow(0)
	
	data.object.anyo[donde]            = anyo
	data.object.anyofra[donde]         = anyofra
	data.object.cambio[donde]          = cambio	
	data.object.divisas[donde]         = divisas
	data.object.empresa[donde]         = codigo_empresa
	data.object.factura[donde]         = factura
	data.object.fcobro[donde]          = fcobro
	data.object.fvto[donde]            = fvto
	data.object.importe[donde]         = importe
	data.object.moneda[donde]          = moneda
	data.object.moneda_empresa[donde]  = moneda_empresa
	data.object.orden[donde]           = orden
	data.object.recibo[donde]          = recibo
	data.object.situacion[donde]       = situacion
	data.object.tipodoc[donde]         = tipodoc
	data.object.ffra[donde]            = ffra
	data.object.linea_historico[donde] = arg_linea_historico
next

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_asignar_sin_detalle ();string  historico
long    donde,indice,total,anyo,orden
int     anyo_agrupa,efecto_agrupa,linea_historico
dec     importe_efecto,importe_asignado,importe_total_asignado
boolean bien = true,continuar = true

if continuar then
	donde = dw_pagos_a_cuenta_pendientes.getrow()
	if donde > 0 then
		anyo_agrupa     = dw_pagos_a_cuenta_pendientes.object.anyo[donde]
		efecto_agrupa   = dw_pagos_a_cuenta_pendientes.object.orden[donde]
		historico       = dw_pagos_a_cuenta_pendientes.object.historico[donde]
		linea_historico = dw_pagos_a_cuenta_pendientes.object.linea_historico[donde]
				
		if historico = "N" then
			update carefectos
			set    agrupado = 'S'
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo_agrupa
			and    orden        = :efecto_agrupa;
			
			if sqlca.sqlcode <> 0 then 
				bien = false					
			end if
		else						
			update carhistorico
			set    agrupado = 'S'
			where  empresa      = :codigo_empresa
			and    anyo         = :anyo_agrupa
			and    orden        = :efecto_agrupa
			and    linea        = :linea_historico;
			
			if sqlca.sqlcode <> 0 then 
				bien = false					
			end if			
		end if
		
		if bien then
			commit;
		else
			rollback;
			messagebox("Atención Error","La operación no se actualiza.")
		end if
	end if
end if

end subroutine

event open;call super::open;string moneda_empresa

This.title = "GESTIÓN PAGOS A CUENTA CLIENTE"

em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())

f_activar_campo(uo_cliente.em_campo)

moneda_empresa = f_moneda_empresa(codigo_empresa)
em_pendiente_asignar.SetMask(DecimalMask!,f_mascara_moneda(moneda_empresa))


end event

on w_gestion_pagos_a_cuenta_cliente.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_8=create st_8
this.st_9=create st_9
this.dw_pagos_a_cuenta_asignados=create dw_pagos_a_cuenta_asignados
this.dw_efectos_cliente=create dw_efectos_cliente
this.dw_detalle_pagos_a_cuenta_asignados=create dw_detalle_pagos_a_cuenta_asignados
this.cb_asignar=create cb_asignar
this.dw_pagos_a_cuenta_pendientes=create dw_pagos_a_cuenta_pendientes
this.cb_consulta=create cb_consulta
this.em_pendiente_asignar=create em_pendiente_asignar
this.st_2=create st_2
this.cb_quitar=create cb_quitar
this.cb_asignar_sin_detalle=create cb_asignar_sin_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.gb_cuenta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.st_8
this.Control[iCurrent+10]=this.st_9
this.Control[iCurrent+11]=this.dw_pagos_a_cuenta_asignados
this.Control[iCurrent+12]=this.dw_efectos_cliente
this.Control[iCurrent+13]=this.dw_detalle_pagos_a_cuenta_asignados
this.Control[iCurrent+14]=this.cb_asignar
this.Control[iCurrent+15]=this.dw_pagos_a_cuenta_pendientes
this.Control[iCurrent+16]=this.cb_consulta
this.Control[iCurrent+17]=this.em_pendiente_asignar
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.cb_quitar
this.Control[iCurrent+20]=this.cb_asignar_sin_detalle
end on

on w_gestion_pagos_a_cuenta_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.dw_pagos_a_cuenta_asignados)
destroy(this.dw_efectos_cliente)
destroy(this.dw_detalle_pagos_a_cuenta_asignados)
destroy(this.cb_asignar)
destroy(this.dw_pagos_a_cuenta_pendientes)
destroy(this.cb_consulta)
destroy(this.em_pendiente_asignar)
destroy(this.st_2)
destroy(this.cb_quitar)
destroy(this.cb_asignar_sin_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_gestion_pagos_a_cuenta_cliente
integer x = 1061
integer y = 28
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_gestion_pagos_a_cuenta_cliente
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_gestion_pagos_a_cuenta_cliente
integer x = 9
integer y = 8
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_gestion_pagos_a_cuenta_cliente
integer x = 3506
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type gb_3 from groupbox within w_gestion_pagos_a_cuenta_cliente
integer x = 2633
integer y = 84
integer width = 983
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_gestion_pagos_a_cuenta_cliente
integer x = 1527
integer y = 84
integer width = 1102
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_cliente from u_em_campo_2 within w_gestion_pagos_a_cuenta_cliente
event destroy ( )
integer x = 270
integer y = 124
integer width = 1225
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"

end event

event modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
end event

type gb_cuenta from groupbox within w_gestion_pagos_a_cuenta_cliente
integer x = 9
integer y = 84
integer width = 1509
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_gestion_pagos_a_cuenta_cliente
integer x = 37
integer y = 132
integer width = 233
integer height = 68
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
string text = "Cliente :"
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_gestion_pagos_a_cuenta_cliente
integer x = 1874
integer y = 124
integer width = 283
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_gestion_pagos_a_cuenta_cliente
integer x = 2309
integer y = 124
integer width = 293
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_gestion_pagos_a_cuenta_cliente
integer x = 2171
integer y = 132
integer width = 114
integer height = 68
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
string text = "al"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_gestion_pagos_a_cuenta_cliente
integer x = 1550
integer y = 132
integer width = 315
integer height = 68
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
string text = "Facturas Del"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_pagos_a_cuenta_asignados from datawindow within w_gestion_pagos_a_cuenta_cliente
integer y = 1228
integer width = 2034
integer height = 996
integer taborder = 60
boolean titlebar = true
string title = "Pagos a cuenta asignados"
string dataobject = "dw_gestion_pagos_a_cuenta_cliente3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//str_parametros lstr_param
//IF Row <> 0 Then
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
//  OpenSheetWithParm(wi_mant_carefectos,lstr_param,Parent,3,Original!) 
//End If
end event

event rbuttondown;//Integer linea,an,ord
//String agrup
//linea = row
//if linea=0 then return
//agrup =  This.GetItemString(linea,"agrupado")
//
//if agrup="S" Then
//	
//	an =this.GetItemNumber(row,"anyo")
//	ord =this.GetItemNumber(row,"orden")
//	
//	str_parametros lstr_param 
//	lstr_param.i_nargumentos=3
//	lstr_param.s_argumentos[1]=codigo_empresa
//	lstr_param.s_argumentos[2]=string(an)
//	lstr_param.s_argumentos[3]=string(ord)
//	
//	OpenSheetWithParm(w_detalle_agrupado,lstr_param,Parent,3,Original!)
//
//End If
end event

event clicked;int    anyo,linea_historico
long   orden
string historico

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setrow(row)

	
	anyo            = this.object.anyo[row] 
	orden           = this.object.orden[row] 
	linea_historico = this.object.linea_historico[row] 
	historico       = this.object.historico[row] 
	
	f_mostrar_detalle_pago_a_cuenta_asignado(dw_detalle_pagos_a_cuenta_asignados,anyo,orden,linea_historico,historico)
end if

end event

type dw_efectos_cliente from datawindow within w_gestion_pagos_a_cuenta_cliente
integer x = 2039
integer y = 232
integer width = 1582
integer height = 996
integer taborder = 30
boolean titlebar = true
string title = "Efectos pendientes"
string dataobject = "dw_gestion_pagos_a_cuenta_cliente2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenSheetWithParm(wi_mant_carefectos,lstr_param,Parent,3,Original!) 
End If
end event

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenSheetWithParm(w_detalle_agrupado,lstr_param,Parent,3,Original!)


End If
end event

event clicked;string marca

if row > 0 then
	marca = this.object.marca[row]
	
	if marca = "S" then
		marca = "N"
		this.object.importe_asignado[row]  = 0
		this.object.divisas_asignadas[row] = 0		
	else
		marca = "S"
		this.object.importe_asignado[row]  = this.object.importe[row]
		this.object.divisas_asignadas[row] = this.object.divisas[row]		
	end if
	
	this.object.marca[row] = marca
end if
dec  importe_pago_a_cuenta,importe_total_asignado,exceso
long indice,total

indice = dw_pagos_a_cuenta_pendientes.getrow()

if indice > 0 then
	importe_pago_a_cuenta  = dw_pagos_a_cuenta_pendientes.object.importe[indice]
else	
	importe_pago_a_cuenta  = 0
end if

importe_total_asignado = 0

total = this.rowcount()

for indice = 1 to total
	if this.object.marca[indice] = "S" then 
		importe_total_asignado = importe_total_asignado + this.object.importe_asignado[indice]
	end if
next

if marca = "S" then
	if (importe_pago_a_cuenta - importe_total_asignado) < 0 then
		exceso = importe_total_asignado - importe_pago_a_cuenta		
		if exceso >= this.object.importe[row] then
			this.object.marca[row] = "N"
			this.object.importe_asignado[row]  = 0
			this.object.divisas_asignadas[row] = 0
			importe_total_asignado = importe_total_asignado - this.object.importe[row]
		else
			this.object.importe_asignado[row]  = this.object.importe[row] - exceso
			//this.object.divisas_asignadas[row] = this.object.importe_asignado[row] / this.object.cambio[row]
			this.object.divisas_asignadas[row] = this.object.importe_asignado[row] * this.object.cambio[row]
			importe_total_asignado = importe_total_asignado - exceso
		end if
	end if
end if

em_pendiente_asignar.text = string(importe_pago_a_cuenta - importe_total_asignado)

end event

type dw_detalle_pagos_a_cuenta_asignados from datawindow within w_gestion_pagos_a_cuenta_cliente
integer x = 2039
integer y = 1228
integer width = 1582
integer height = 996
integer taborder = 40
boolean titlebar = true
string title = "Detalle Pagos a cuenta asignados"
string dataobject = "dw_gestion_pagos_a_cuenta_cliente4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//str_parametros lstr_param
//IF Row <> 0 Then
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
//  OpenSheetWithParm(wi_mant_carefectos,lstr_param,Parent,3,Original!) 
//End If
end event

event rbuttondown;//Integer linea,an,ord
//String agrup
//linea = row
//if linea=0 then return
//agrup =  This.GetItemString(linea,"agrupado")
//
//if agrup="S" Then
//	
// an =this.GetItemNumber(row,"anyo")
// ord =this.GetItemNumber(row,"orden")
//
//	str_parametros lstr_param 
//   lstr_param.i_nargumentos=3
//   lstr_param.s_argumentos[1]=codigo_empresa
//   lstr_param.s_argumentos[2]=string(an)
//   lstr_param.s_argumentos[3]=string(ord)
//
//   OpenSheetWithParm(w_detalle_agrupado,lstr_param,Parent,3,Original!)
//
//
//End If
end event

type cb_asignar from commandbutton within w_gestion_pagos_a_cuenta_cliente
integer x = 41
integer y = 1140
integer width = 1829
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asignar"
end type

event clicked;if messagebox("Confirmación","¿desea asignar los efectos seleccionados?",Question!,YesNo!,1) = 1 then
	f_asignar()
	cb_consulta.triggerevent(clicked!)
end if
end event

type dw_pagos_a_cuenta_pendientes from datawindow within w_gestion_pagos_a_cuenta_cliente
integer x = 5
integer y = 232
integer width = 2034
integer height = 996
boolean titlebar = true
string title = "Pagos a cuenta sin asignar"
string dataobject = "dw_gestion_pagos_a_cuenta_cliente1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//str_parametros lstr_param
//IF Row <> 0 Then
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
//  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
//  OpenSheetWithParm(wi_mant_carefectos,lstr_param,Parent,3,Original!) 
//End If
end event

event rbuttondown;//Integer linea,an,ord
//String agrup
//linea = row
//if linea=0 then return
//agrup =  This.GetItemString(linea,"agrupado")
//
//if agrup="S" Then
//	
// an =this.GetItemNumber(row,"anyo")
// ord =this.GetItemNumber(row,"orden")
//
//	str_parametros lstr_param 
//   lstr_param.i_nargumentos=3
//   lstr_param.s_argumentos[1]=codigo_empresa
//   lstr_param.s_argumentos[2]=string(an)
//   lstr_param.s_argumentos[3]=string(ord)
//
//   OpenSheetWithParm(w_detalle_agrupado,lstr_param,Parent,3,Original!)
//
//
//End If
end event

event clicked;dec  importe_pago_a_cuenta,importe_total_asignado
long indice,total

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	this.setrow(row)
	
	importe_pago_a_cuenta  = this.object.importe[row]
	
	importe_total_asignado = 0
	
	total = dw_efectos_cliente.rowcount()
	
	for indice = 1 to total
		if dw_efectos_cliente.object.marca[indice] = "S" then 
			importe_total_asignado = importe_total_asignado + dw_efectos_cliente.object.importe_asignado[indice]
		end if
	next
	
	em_pendiente_asignar.text = string(importe_pago_a_cuenta - importe_total_asignado)
end if

end event

type cb_consulta from commandbutton within w_gestion_pagos_a_cuenta_cliente
integer x = 2642
integer y = 116
integer width = 960
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;em_pendiente_asignar.text = "0"

f_mostrar_pagos_a_cuenta_sin_asignar(dw_pagos_a_cuenta_pendientes)
f_mostrar_pagos_pendientes(dw_efectos_cliente)

f_mostrar_pagos_a_cuenta_asignados(dw_pagos_a_cuenta_asignados)
dw_detalle_pagos_a_cuenta_asignados.reset()
end event

type em_pendiente_asignar from editmask within w_gestion_pagos_a_cuenta_cliente
integer x = 3232
integer y = 1132
integer width = 293
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gestion_pagos_a_cuenta_cliente
integer x = 2926
integer y = 1140
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Pendiente :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_quitar from commandbutton within w_gestion_pagos_a_cuenta_cliente
integer x = 41
integer y = 2132
integer width = 1906
integer height = 64
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quitar"
end type

event clicked;if messagebox("Confirmación","¿desea quitar los efectos seleccionados?",Question!,YesNo!,1) = 1 then
	f_quitar()
	cb_consulta.triggerevent(clicked!)
end if

end event

type cb_asignar_sin_detalle from picturebutton within w_gestion_pagos_a_cuenta_cliente
integer x = 1874
integer y = 1140
integer width = 73
integer height = 64
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Bmp\CHECK_X.BMP"
alignment htextalign = left!
end type

event clicked;if messagebox("Confirmación","¿desea asignar los efectos seleccionados?",Question!,YesNo!,1) = 1 then
	f_asignar_sin_detalle()
	cb_consulta.triggerevent(clicked!)
end if
end event

