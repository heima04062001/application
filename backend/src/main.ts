import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // CORSを有効にする
  app.enableCors(); // デフォルトで全てのオリジンからのリクエストを許可する

  await app.listen(3000);
}
bootstrap();

